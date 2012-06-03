class EuclidMessagesController < ApplicationController
  # GET /euclid_messages
  # GET /euclid_messages.json
  def index
    @euclid_messages = EuclidMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @euclid_messages }
    end
  end

  # GET /euclid_messages/1
  # GET /euclid_messages/1.json
  def show
    @euclid_message = EuclidMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @euclid_message }
    end
  end

  # GET /euclid_messages/new
  # GET /euclid_messages/new.json
  def new
    @euclid_message = EuclidMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @euclid_message }
    end
  end

  # GET /euclid_messages/1/edit
  def edit
    @euclid_message = EuclidMessage.find(params[:id])
  end

  # POST /euclid_messages
  # POST /euclid_messages.json
  def create
    @euclid_message = EuclidMessage.new(params[:euclid_message])

    respond_to do |format|
      if @euclid_message.save
        format.html { redirect_to @euclid_message, notice: 'Euclid message was successfully created.' }
        format.json { render json: @euclid_message, status: :created, location: @euclid_message }
      else
        format.html { render action: "new" }
        format.json { render json: @euclid_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /euclid_messages/1
  # PUT /euclid_messages/1.json
  def update
    @euclid_message = EuclidMessage.find(params[:id])

    respond_to do |format|
      if @euclid_message.update_attributes(params[:euclid_message])
        format.html { redirect_to @euclid_message, notice: 'Euclid message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @euclid_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /euclid_messages/1
  # DELETE /euclid_messages/1.json
  def destroy
    @euclid_message = EuclidMessage.find(params[:id])
    @euclid_message.destroy

    respond_to do |format|
      format.html { redirect_to euclid_messages_url }
      format.json { head :no_content }
    end
  end
end
