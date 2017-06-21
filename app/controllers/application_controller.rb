class ApplicationController < ActionController::Base
	include ActionController::MimeResponds

	protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token

	helper_method :logged_in?
	helper_method :get_current_user

	Yt.configuration.api_key = 'AIzaSyC3slR3xP_PQViWhdONhBe5iLWqsZP5vB4'

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
		unless logged_in?
		  redirect_to sessions_new_path 
		  flash[:alert] = "Log in to continue"
		end
	end
end