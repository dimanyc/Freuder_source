class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user,:set_filters


	def current_user
		if session[:user_id] 
			@current_user ||= User.find(session[:user_id])
		else
			return
		end

	end	

	helper_method :current_user


	def	set_filters
		if current_user.filters && current_user
			@filters = current_user.filters 
		end
	end

		# def current_user
		# 	@current_user ||= User.find(session[:user_id]) if session[:user_id]
		# 	rescue ActiveRecord::RecordNotFound # rescues if current_user is nil 
		# 		redirect_to home_path
		# 		flash[:alert] = "Please Log-In First"
		# end
		# 	helper_method :current_user

end
