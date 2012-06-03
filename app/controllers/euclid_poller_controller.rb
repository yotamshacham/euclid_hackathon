class EuclidPollerController < ApplicationController

  # GET /euclid_poller
  # GET /euclid_poller.json
  def index
    # https://store.euclidelements.com/alerts.json?credential=hackathon&shopper_id=187
    
    puts "Polling.."
    
    # During poll:
    #   1) Obtain list of alerts
    #   2) For every alert, get user record
    #   3) If proximity has changed from !close to close
    #       3a) Get most current message
    #       3b) Get user_message join item, if note is empty:
    #           3b.1) Send SMS to user sms
    #           3b.2) Mark user_message note: "sent"
    #
    # looks like this:
    # {"detected_at"=>1338667404, "id"=>22491, "proximity"=>"close", "shopper_id"=>187, "shopper_mac"=>"00254B51CD6B", "shopper_name"=>"yotam"}
    # {"detected_at"=>1338667393, "id"=>22484, "proximity"=>"detected", "shopper_id"=>187, "shopper_mac"=>"00254B51CD6B", "shopper_name"=>"yotam"}
    # {"detected_at"=>1338667074, "id"=>22359, "proximity"=>"detected", "shopper_id"=>187, "shopper_mac"=>"00254B51CD6B", "shopper_name"=>"yotam"}
    # {"detected_at"=>1338667058, "id"=>22348, "proximity"=>"detected", "shopper_id"=>187, "shopper_mac"=>"00254B51CD6B", "shopper_name"=>"yotam"}
    # {"detected_at"=>1338667046, "id"=>22345, "proximity"=>"detected", "shopper_id"=>187, "shopper_mac"=>"00254B51CD6B", "shopper_name"=>"yotam"}

    httpResponse1 = RestClient.get 'https://store.euclidelements.com/alerts.json', {:params => {'credential' => 'hackathon', 'shopper_id' => '187'}};
    httpResponse2 = RestClient.get 'https://store.euclidelements.com/alerts.json', {:params => {'credential' => 'hackathon', 'shopper_id' => '209'}}
    alerts1 = JSON.parse httpResponse1
    alerts2 = JSON.parse httpResponse2
    #puts "ALERTS"
    #puts "------"
    #puts alerts

    latestStatuses = {}
    (alerts1 + alerts2).each do |alertsLine|      
      shopper_mac = alertsLine["shopper_mac"]
      if not latestStatuses.include?(shopper_mac) or latestStatuses[shopper_mac]["detected_at"].to_i < alertsLine["detected_at"].to_i
        latestStatuses[shopper_mac] = {"proximity" => alertsLine["proximity"], "detected_at" => alertsLine["detected_at"]}
      end
    end

    #puts "LATEST"
    #puts "------"
    #puts "LATEST STATUSES: [",latestStatuses,"]"
    
    latestStatuses.each_pair do |mac_addr,v|
      @euclid_user = EuclidUser.find_by_mac_addr(mac_addr)
      if @euclid_user == nil
        next
      end
      
      latestLiveProximity = latestStatuses[mac_addr]["proximity"]
      latestDBProximity = @euclid_user.proximity
      puts "--------------------------------------------------------------"
      puts "User " + @euclid_user.name + " latestLiveProximity: " + latestLiveProximity + ", latestDBProximity: " + latestDBProximity
      
      msg, user_message = getFirstUserMessage(@euclid_user)
      puts "UserMessage, body: " + msg.body + "[" + user_message.detected.to_s + "," + user_message.close.to_s + "," + user_message.linkpressed.to_s + "," + user_message.purchased.to_s + "]"
      
      if (latestLiveProximity == "detected" and not (user_message.detected==1))        
        sendOutgoingSMS(@euclid_user, msg.body, msg.id)
        user_message.detected = 1;
      end
      
      if (latestLiveProximity == "close" and not (user_message.detected==1 or user_message.close==1))
        sendOutgoingSMS(@euclid_user, msg.body, msg.id);
        user_message.close = 1;
        user_message.detected = 1;
      end

      user_message.save(); 
            
      @euclid_user.proximity = latestLiveProximity
      @euclid_user.save();
      puts "--------------------------------------------------------------"
    end
    
    respond_to do |format|
      format.html { render :nothing => true }
      format.json { render :nothing => true }
    end
  end
  
  def getFirstUserMessage(euclid_user)
    #puts 'getFirstUserMessage'
    msgs = EuclidMessage.all
    msg = msgs[-1]
    #puts 'firstMessage: ' + msg.inspect
    
    user_messages = EuclidUserMessage.find(:all, :conditions => ["euclid_user_id = ? and euclid_message_id = ?", euclid_user.id.to_s, msg.id.to_s] )
    if (user_messages.length == 0)
      #puts "getFirstUserMessage, no user message found"
      user_message = EuclidUserMessage.new;
      user_message.euclid_user_id = euclid_user.id;
      user_message.euclid_message_id = msg.id;
      user_message.detected = 0;
      user_message.close = 0;
      user_message.linkpressed = 0;
      user_message.purchased = 0;
    else
      #puts "getFirstUserMessage, user message found"
      user_message = user_messages[0]
    end
    
    return msg, user_message
  end
  
  def sendOutgoingSMS(euclid_user, text, msgId)
    text = text.gsub("%link%", "http://localhost:3000/euclid_link_callback?mID=" + msgId.to_s + "&uID=" + euclid_user.id.to_s)
    
    puts "sendOutgoingSMS, sms: " + euclid_user.sms + ", text: " + text
    path = 'http://rest.nexmo.com/sms/json'
    params = {'username' => '8937eaeb', 'password' => 'c7593493', 'from' => '14144555532', 'to' => euclid_user.sms, 'text' => text}    
    s = RestClient.get path, {:params => params}
    puts 'Nexmo response:' + s
    sleep(2)
  end

end
