class HomeController < ApplicationController
	def index
		
		@messages = Message.all
		render layout: 'home'

	end
end
