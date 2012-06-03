class EuclidLinkCallbackController < ApplicationController
  
  def index    
    userID = params["uID"].to_i
    msgID = params["mID"].to_i
    
    puts "link callback: uID=" + userID.to_s + ", mID=" + msgID.to_s;
    
    @euclid_user = EuclidUser.find_by_id(userID)
    if @euclid_user == nil
      puts "link callback: unable to find user"
      return
    end

    @msg = EuclidMessage.find_by_id(msgID)
    if @msg == nil
      puts "link callback: unable to find msg"
      return
    end
    
    @user_messages = EuclidUserMessage.find(:all, :conditions => ["euclid_user_id = ? and euclid_message_id = ?", userID.to_s, msgID.to_s] )
    if (@user_messages.length == 0)
      puts "link callback: unable to find user message"
      return
    end
    
    user_message = @user_messages[0];
    user_message.linkpressed = 1;
    user_message.save();
    
    responseString = "Hi, " + @euclid_user.name + "\nThanks for responding to msg: " + @msg.title
    
    respond_to do |format|
      format.html { render :inline => responseString }
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
  
end
