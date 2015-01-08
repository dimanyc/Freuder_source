class UsersController < ApplicationController
	# Read
	def index
	end

	def show
		@user = User.find(session[:user_id])

		if current_user == @user 
			@messages = Message.all#add filtering here
		else
			flash[:alert] = "Please log-in first"
			redirect_to home_path
		end

	end
end
