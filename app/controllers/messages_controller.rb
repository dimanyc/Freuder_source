class MessagesController < ApplicationController

	# Create
	def new
		@message = Message.new
	end

	### Tweet from App
	def create
		@message = Message.new(message_params)

		if  @message.save
			$client.update(@message.body)
			current_user.messages << @message
			flash[:notice] = "Message Sent"

		else
			flash[:alert] = "Problem sending your message"
		end

		redirect_to user_path(current_user)
	end

	def refresh # loads new data from Twitter
		@tweets = $client.home_timeline

		
		if @tweets.each do |tweet|
				Message.create( body:tweet.text, author:tweet.user.screen_name)
			end	# @tweets.each do |tweet|

			redirect_to user_path(current_user)	
			flash[:notice] = "Message feed has been updated"

		else

			flash[:alert] = "Problem reloading the message feed"
		end
		
	end	


	def analyze # crawls through new tweets with current_user.filters 
		@messages = Message.all

		@messages.each do |message|
			current_user.filters.each do |filter|
			
				if 	filter.evaluate_message(message)
						filter.messages << message
						flash[:notice] = 'Found messages that are mathing your tags' 

				else
					respond_to do |format|
						format.html { flash[:notice] = 'No new messages are matching any of your tags' }
						format.json { render json: @message.errors, status: :unprocessable_entity }
					end # respond_to
				end # filter.evaluate_message
			end # current_user.filters.each do |filter|
		end	# @messages.each 

		redirect_to user_path(current_user)

	end # def analyze


	### ADVANCED CREATE:
	# def create
	# 	@message = Message.new(message_params)

		
	# 		if @message.save
	# 			$twitter.update(@message)
				# current_user.filters.each do |filter|
					

				# 	if 	filter.evaluate_message(@message)
				# 			filter.messages << @message
				# 			flash[:notice] = 'Message matches one or more of your filters' 
				# 	else
				# 		respond_to do |format|
				# 			format.html { flash[:notice] = 'Not matching any filters' }
				# 			format.json { render json: @message.errors, status: :unprocessable_entity }
				# 		end
				# 	end
				

				# end
	# 			redirect_to user_path(current_user)
	# 		end
			

	# end


	# Read
	def index 
		@messages = Message.all
	end

	def show
		
	end


	# Strong Params 
	private 

	def message_params
		params.require(:message).permit(:body,:author,:user_id)
	end



end
