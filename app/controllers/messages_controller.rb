class MessagesController < ApplicationController

	# Create
	def new
		@message = Message.new
	end

	### STANDARD 'CREATE'
	# def create
	# 	@message = Message.new(message_params)

	# 	if @message.save
	# 		current_user.messages << @message
	# 		flash[:notice] = "message created"
	# 		redirect_to user_path(current_user)
	# 	else
	# 		flash[:alert] = "Problem saving a message"
	# 		render @user
	# 	end
	# end

	### ADVANCED CREATE:
	def create
		@message = Message.new(message_params)

		if @message.save
			current_user.filters.each do |filter|

				if filter.evaluate_message(@message)
					filter.messages << @message
					flash[:notice] = "Message matches one or more of your filters"
				else
					flash[:notice] = "Not matching any filters"
				end
			redirect_to :back

			end

		end	

	end


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
