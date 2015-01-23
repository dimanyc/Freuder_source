class UsersController < ApplicationController

	# Read
	def index
	end


	def show
		if current_user		
			@messages = Message.order(:created_at)
			@user_filters = current_user.filters
			@filtered_messages = current_user.messages
			@image = current_user.image_url.gsub!("_normal","")
			@message = Message.new
			@filter = Filter.new
		else
			redirect_to home_path
		end
	end


end
