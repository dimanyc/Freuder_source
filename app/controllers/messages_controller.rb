class MessagesController < ApplicationController

	# Create
	def new
		@message = Message.new
	end


	# def create
	# 	Message.post_tweet(params["body"])
	# 	redirect_to user_path(current_user)
	# end

	def create
		@message = Message.new(message_params)



		if  @message.save
			$client.update(@message.body)
			current_user.messages << @message 
			flash[:notice] = "Message Sent"

		elsif @message.body == nil
			flash[:alert] = "Cannot send an empty message"
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
				filter.filtered_message_ids ||= []
				message.slipped ||= ""
				if 	filter.evaluate_message(message)
					#filter.slipped_count += 1 
					flash[:notice] = "Some message(s) matched your tags"
						filter.messages << message
						current_user.messages << message
						filter.filtered_message_ids << message.id.to_s
						#message.slipped << slip
	 					filter.save
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
		params.require(:message).permit(:body,:author, :filtered_message_ids)
	end



end
