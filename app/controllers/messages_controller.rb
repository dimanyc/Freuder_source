class MessagesController < ApplicationController
	# Read
	def index 
		@messages = Message.all
	end

	def show
		@message = Message.find(params[:id])
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
