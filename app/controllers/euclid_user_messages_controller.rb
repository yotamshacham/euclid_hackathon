require 'rest_client'

class EuclidUserMessagesController < ApplicationController
  # GET /euclid_user_messages
  # GET /euclid_user_messages.json
  def index
    @euclid_user_messages = EuclidUserMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @euclid_user_messages }
    end
  end

  # GET /euclid_user_messages/1
  # GET /euclid_user_messages/1.json
  def show
    @euclid_user_message = EuclidUserMessage.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @euclid_user_message }
    end
  end

  # GET /euclid_user_messages/new
  # GET /euclid_user_messages/new.json
  def new
    @euclid_user_message = EuclidUserMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @euclid_user_message }
    end
  end

  # GET /euclid_user_messages/1/edit
  def edit
    @euclid_user_message = EuclidUserMessage.find(params[:id])
  end

  # POST /euclid_user_messages
  # POST /euclid_user_messages.json
  def create
    @euclid_user_message = EuclidUserMessage.new(params[:euclid_user_message])

    respond_to do |format|
      if @euclid_user_message.save
        format.html { redirect_to @euclid_user_message, notice: 'Euclid user message was successfully created.' }
        format.json { render json: @euclid_user_message, status: :created, location: @euclid_user_message }
      else
        format.html { render action: "new" }
        format.json { render json: @euclid_user_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /euclid_user_messages/1
  # PUT /euclid_user_messages/1.json
  def update
    @euclid_user_message = EuclidUserMessage.find(params[:id])

    respond_to do |format|
      if @euclid_user_message.update_attributes(params[:euclid_user_message])
        format.html { redirect_to @euclid_user_message, notice: 'Euclid user message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @euclid_user_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /euclid_user_messages/1
  # DELETE /euclid_user_messages/1.json
  def destroy
    @euclid_user_message = EuclidUserMessage.find(params[:id])
    @euclid_user_message.destroy

    respond_to do |format|
      format.html { redirect_to euclid_user_messages_url }
      format.json { head :no_content }
    end
  end
end
