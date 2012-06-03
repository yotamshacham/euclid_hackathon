class EuclidUsersController < ApplicationController
  # GET /euclid_users
  # GET /euclid_users.json
  def index
    @euclid_users = EuclidUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @euclid_users }
    end
  end

  # GET /euclid_users/1
  # GET /euclid_users/1.json
  def show
    @euclid_user = EuclidUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @euclid_user }
    end
  end

  # GET /euclid_users/new
  # GET /euclid_users/new.json
  def new
    @euclid_user = EuclidUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @euclid_user }
    end
  end

  # GET /euclid_users/1/edit
  def edit
    @euclid_user = EuclidUser.find(params[:id])
  end

  # POST /euclid_users
  # POST /euclid_users.json
  def create
    @euclid_user = EuclidUser.new(params[:euclid_user])
    @euclid_user.proximity = "distant";

    respond_to do |format|
      if @euclid_user.save
        format.html { redirect_to @euclid_user, notice: 'Euclid user was successfully created.' }
        format.json { render json: @euclid_user, status: :created, location: @euclid_user }
      else
        format.html { render action: "new" }
        format.json { render json: @euclid_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /euclid_users/1
  # PUT /euclid_users/1.json
  def update
    @euclid_user = EuclidUser.find(params[:id])

    respond_to do |format|
      if @euclid_user.update_attributes(params[:euclid_user])
        format.html { redirect_to @euclid_user, notice: 'Euclid user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @euclid_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /euclid_users/1
  # DELETE /euclid_users/1.json
  def destroy
    @euclid_user = EuclidUser.find(params[:id])
    @euclid_user.destroy

    respond_to do |format|
      format.html { redirect_to euclid_users_url }
      format.json { head :no_content }
    end
  end
end
