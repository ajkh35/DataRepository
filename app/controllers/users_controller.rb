class UsersController < ApplicationController
  
  before_action :authorize, :except => [:new,:create]

  def new
    if logged_in?
      redirect_to user_path(get_current_user)
    else
  	 @user = User.new
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		login(@user)
  		redirect_to user_path(@user)
  		flash[:alert] = "Successful created account"
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
      redirect_to user_path(@user)
      flash[:alert] = "Updated details"
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])
    @menuOption = params[:token]
    if verify_user(@user)
      if @menuOption=='dashboard'
        dashboard(@user)
      elsif @menuOption=='music'
        get_music(@user)
      elsif @menuOption=='movies'
        get_movies(@user)
      elsif @menuOption=='games'
        get_games(@user)
      else
        get_documents(@user)
      end 
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

  def dashboard(user)
    @songs = Music.where(user_id: user.id)
    @movies = Movie.where(user_id: user.id)
    @games = Game.where(user_id: user.id)
  end

  def get_music(user)
    @songs = Music.where(user_id: @user.id)
    @movies = nil
    @games = nil
  end

  def get_movies(user)
    @movies = Movie.where(user_id: user.id)
    @songs = nil
    @games = nil
  end

  def get_games(user)
    @games = Game.where(user_id: user.id)
    @movies = nil
    @songs = nil
  end

  def get_documents(user)
  end
end