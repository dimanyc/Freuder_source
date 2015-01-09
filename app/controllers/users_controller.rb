class UsersController < ApplicationController
	# Read
	def index
	end

	def show
		# if session[:user_id] && current_user == session[:user_id]
		# 	@user = current_user
		# 	@messages = Message.all? 
		# else
		# 	flash[:alert] = "Please log-in first"
		# 	redirect_to home_path
		# end
		@user = current_user
		@messages = Message.all
		@image = current_user.image_url.gsub!("_normal","")
	end
end
