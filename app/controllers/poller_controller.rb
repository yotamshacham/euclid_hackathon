class PollerController < ApplicationController

  # GET /poller
  # GET /euclid_user_messages.json
  def index
    @euclid_user_messages = EuclidUserMessage.all

    # https://store.euclidelements.com/alerts.json?credential=hackathon&shopper_id=187
    s = RestClient.get 'https://store.euclidelements.com/alerts.json', {:params => {'credential' => 'hackathon', 'shopper_id' => '187'}}
    puts s
    
    # During poll:
    #   1) Obtain list of alerts
    #   2) For every alert, get user record
    #   3) If proximity has changed from !close to close
    #       3a) Get most current message
    #       3b) Get user_message join item, if note is empty:
    #           3b.1) Send SMS to user sms
    #           3b.2) Mark user_message note: "sent"

    puts JSON.parse s

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @euclid_user_messages }
    end
  end

end
