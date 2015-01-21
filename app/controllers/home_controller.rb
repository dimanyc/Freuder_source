class HomeController < ApplicationController
	def index
		if current_user
			redirect_to user_path(current_user)
			flash[:notice] = "Welcome back, @#{current_user.username}!"
		else
			render layout: 'home'
		end

	end
end
