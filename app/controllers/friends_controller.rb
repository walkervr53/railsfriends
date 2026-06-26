class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  # GET /friends
  def index
    @friends = Friend.all
  end

  # GET /friends/1
  def show
  end

  # GET /friends/new
  def new
    #@friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  def create
    #@friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @friend.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /friends/1
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: "Friend was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @friend.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /friends/1
  def destroy
    @friend.destroy!

    respond_to do |format|
      format.html { redirect_to friends_path, notice: "Friend was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_friend
      @friend = Friend.find(params.expect(:id))
    end

    def correct_user
      @friend = current_user.friends.find_by(id: params.expect(:id))

      redirect_to friends_path,
                  notice: "Not authorized to edit this friend." if @friend.nil?
    end

    def friend_params
      params.expect(friend: [
        :first_name,
        :last_name,
        :email,
        :phone,
        :twitter,
        :user_id
      ])
    end
end