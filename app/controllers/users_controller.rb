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
		@messages = current_user.messages
		@slips = Filter.where(user_id: current_user.id).select(:slips).map(&:slips).join(" ").split(", ")
		
		@messages.each do |message|
			while @slips.any?{ |slip| message[slip] } do 
				filtered_message = FilteredMessage.new(body:message.body, author:message.author)
				filtered_message.save 
				current_user.filtered_messages << filtered_message
				next
			end
		end

	end

	private 

	def message_params
		params.require(:message).permit(:user_id,:body,:author)
	end

	def filtered_message_params
		params.require(:filtered_message).permit(:user_id,:body,:author)
	end

end
