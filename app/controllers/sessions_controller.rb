class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		redirect_to welcome_Index_path
  	else
      flash[:alert] = "Invalid email/password"
      render 'new'
  	end
  end

  def create_from_nav
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to welcome_Index_path
    else
      redirect_to welcome_Index_path
      flash[:alert] = "Invalid email/password"
    end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end