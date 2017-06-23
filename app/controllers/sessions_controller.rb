class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		redirect_to controller: 'users',action: 'show',id: get_current_user.id,token: 'dashboard'
  	else
      flash[:alert] = "Invalid email/password"
      render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end