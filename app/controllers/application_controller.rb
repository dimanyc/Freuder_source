class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_filters, :set_filtered_messages

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end	

	helper_method :current_user

	private

	def set_filters
		@filters = Filter.find_by(user_id: current_user.id) || Filter.new  # not sure if this would fly...
	end

	def set_filtered_messages
		@filtered_messages = @filters.messages || []
	end


end
