class UsersController < ApplicationController
	#before_action :set_filters, only: [:show, :edit, :update, :destroy]

	# Read
	def index
	end

	def show
		@messages = Message.all.order! 'created_at ASC'
		@user_filters = Filter.where(user_id: current_user.id)
		@image = current_user.image_url.gsub!("_normal","")
		@message = Message.new
		#@followers = $client.followers("dimanyc")
		#@user_tweets = $client.user_timeline("dimanyc")
		#@users_tweets = $client.home_timeline
	end

	# def analyze
	# 	@filtered_messages = current_user.filtered_messages.uniq
	# 	@messages = current_user.messages
	# 	@slips = Filter.where(user_id: current_user.id).select(:slips).map(&:slips)
		
	# 	@messages.each do |m|
	# 		@slips.each do |s|
	# 			if m.body.downcase.include?(s.downcase)
	# 				filtered_message = FilteredMessage.new(body:message.body, author:message.author)
	# 				filtered_message.save
	# 				current_user.filtered_messages << filtered_message
	# 			end
	# 		end
	# 	end
		
	# end

	private 

	def message_params
		params.require(:message).permit(:user_id,:body,:author)
	end

	def filtered_message_params
		params.require(:filtered_message).permit(:user_id,:body,:author)
	end

end
