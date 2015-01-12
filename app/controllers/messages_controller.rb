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

		respond_to do |format|
			if @message.save
				current_user.filters.each do |filter|
					

					if 	filter.evaluate_message(@message)
							filter.messages << @message
							format.html { flash[:notice] = 'Message matches one or more of your filters' }
					else
						format.html { flash[:notice] = 'Not matching any filters' }
						format.json { render json: @message.errors, status: :unprocessable_entity }
					end
				

				end
				redirect_to user_path(current_user)
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
