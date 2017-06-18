class UsersController < ApplicationController
  
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
  end

  def show
  	@user = User.find(params[:id])
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
end