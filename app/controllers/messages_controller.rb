class MessagesController < ApplicationController

	# Create
	def new
		@message = Message.new
	end

	def create
		@message = Message.create(body: @message.body)

		if  @message
			$client.update(@message.body)
			flash[:notice] = "Message Sent"

		else
			flash[:alert] = "Problem sending your message"
		end

		redirect_to user_path(current_user)
	end


	# Read
	def index 
		@messages = Message.all
	end

	def show
		
	end


	# Update
	def analyze # crawls through new tweets with current_user.filters 
		@messages = Message.all

		@messages.each do |message|
			current_user.filters.each do |filter|
			
				if 	filter.evaluate_message(message)
						filter.messages << message
						current_user.messages << message
	 				flash[:notice] = "Some message(s) matched your tags"
				else
					flash[:alert] = "No new messages matched your tags."
				end # filter.evaluate_message
			end # current_user.filters.each do |filter|
		end	# @messages.each 

		redirect_to user_path(current_user)

	end # def analyze

	def refresh # loads new data from Twitter
		@messages = Message.refresh_tweets
		
		if @messages
			redirect_to user_path(current_user)	
			flash[:notice] = "Message feed has been updated"
		else
			flash[:alert] = "Problem reloading the message feed"
		end
		
	end			

	# Destroy
	def destroy
		@messages = Message.all
		@messages.destroy_all

		redirect_to user_path(current_user)
	end


	# Strong Params 
	private 

	def message_params
		params.require(:message).permit(:body,:author,:hashtags,:author_image_url,:replies,:mentions,:messageable_id,:messageable_type)
	end



end
