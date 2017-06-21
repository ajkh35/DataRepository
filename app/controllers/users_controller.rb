class UsersController < ApplicationController
  
  before_action :authorize

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		login(@user)
  		redirect_to controller: 'users',action: 'show',id: @user.id, token: 'user'
  		flash[:notice] = "Successful created account"
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Updated details"
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])
    if verify_user(@user)
      @songs = Music.where(user_id: @user.id)
      @movies = Movie.where(user_id: @user.id)
      @games = Game.where(user_id: @user.id)
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
  end

  private
  def user_params
  	params.require(:user).permit(:email,
                          :password,:password_confirmation,
                          :avatar,
                          :user_name,
                          :first_name,:last_name)
  end

  def verify_user(user)
    if get_current_user.id == user.id
      return true
    else
      return false
    end
  end
end