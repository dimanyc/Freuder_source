class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_action :save_tweets_to_messages	

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end	
	
	helper_method :current_user

	# def save_tweets_to_messages
	# 	# need a scheduler	
	# 		@tweets = $client.home_timeline
			
	# 		@tweets.each do |tweet|
	# 			Message.create( body:tweet.text, author:tweet.user.screen_name)
	# 		end
		
	# end
end
