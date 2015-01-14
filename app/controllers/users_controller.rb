class UsersController < ApplicationController

	# Read
	def index
	end

	def show
		@messages = Message.all.order! 'created_at ASC'
		@filtered_messages = Filter.find_by(user_id: current_user.id).messages
		@user_filters = Filter.where(user_id: current_user.id)
		@image = current_user.image_url.gsub!("_normal","")
		@message = Message.new
		#@followers = $client.followers("dimanyc")
		#@user_tweets = $client.user_timeline("dimanyc")
		#@users_tweets = $client.home_timeline
	end

	private 

	def message_params
		params.require(:message).permit(:user_id,:body,:author)
	end

	def filtered_message_params
		params.require(:filtered_message).permit(:user_id,:body,:author)
	end

end
