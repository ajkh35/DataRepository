class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token

	helper_method :logged_in?
	helper_method :get_current_user

	def login(user)
		session[:user_id] = user.id
	end

	def get_current_user
		@current_user = User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!get_current_user.nil? && (@current_user.id==session[:user_id])
	end

	def log_out
		session.delete(:user_id)
	end

  def authorize
    redirect_to sessions_new_path unless logged_in?
    flash[:alert] = "Log in to continue" unless logged_in?
  end
end