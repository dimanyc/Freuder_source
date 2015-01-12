class UsersController < ApplicationController
	before_action :set_filters, only: [:show, :edit, :update, :destroy]

	# Read
	def index
	end

	def show
		@messages = current_user.messages
		@image = current_user.image_url.gsub!("_normal","")
		@filtered_messages = current_user.filtered_messages
	end

	def analyze
		@filtered_messages = current_user.filtered_messages.uniq
		@messages = Message.all.select {|m| m.user_id == current_user.id }
		@slips = Filter.find_by(user_id:current_user.id).slips.split(", ")
		
		@message.each. do |message|
			if @slips.any?{ |slip| message[slip] }
				filtered_message = FilteredMessage.new(body:message.body, author:message.author)
				filtered_message.save 
		 		current_user.filtered_messages << filtered_message
		 	end
		end

		# @messages.each do |message|
		
		# 	if message.body.downcase.gsub(/[^[[:word:]]\s]/, '').any?@slips { | | message[]}


		# 		filtered_message = FilteredMessage.new(body:message.body, author:message.author)
		# 		filtered_message.save 
		# 		current_user.filtered_messages << filtered_message
		# 	else
		# 		next	
		# 	end
		# 	next
		#end
		


	end

	private 

	def message_params
		params.require(:message).permit(:user_id,:body,:author)
	end

	def filtered_message_params
		params.require(:filtered_message).permit(:user_id,:body,:author)
	end

end
