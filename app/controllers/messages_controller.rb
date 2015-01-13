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


	### ADVANCED CREATE:
	# def create
	# 	@message = Message.new(message_params)

		
	# 		if @message.save
	# 			$twitter.update(@message)
	# 			current_user.filters.each do |filter|
					

	# 				if 	filter.evaluate_message(@message)
	# 						filter.messages << @message
	# 						flash[:notice] = 'Message matches one or more of your filters' 
	# 				else
	# 					respond_to do |format|
	# 						format.html { flash[:notice] = 'Not matching any filters' }
	# 						format.json { render json: @message.errors, status: :unprocessable_entity }
	# 					end
	# 				end
				

	# 			end
	# 			redirect_to user_path(current_user)
	# 		end
			

	# end


	# Read
	def index 
		@messages = Message.all
	end

	def show
		
	end

	def analyze
		@messages = Message.all
		@slips = Slip.all
		@messages.each do |i|
				i.analyze(i,)
			@messages.analyze()
			redirect_to user_path(current_user)
		end
	end

	# Strong Params 
	private 

	def message_params
		params.require(:message).permit(:body,:author,:user_id)
	end



end
