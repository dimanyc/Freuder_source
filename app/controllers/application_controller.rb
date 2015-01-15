class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :set_filtered_messages 
 

	def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	    rescue ActiveRecord::RecordNotFound
	end 

 	helper_method :current_user

	# def set_filtered_messages
	# 	@filtered_messages ||= Filter.find_by(user_id: current_user.id) 
	# 	if @filtered_messages == nil
	# 		@filtered_messages = []
	# 	end
	# 	  rescue ActiveRecord::RecordNotFound
	# end


end
