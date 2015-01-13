class SessionsController < ApplicationController
	# Create
	def create
		@user = User.from_omniauth(env["omniauth.auth"])
		session[:user_id] = @user.id 
		redirect_to user_path(@user)
		flash[:notice] = "Signd In!"
	end

	def destroy
		session[:user_id] = nil
		flash[:alert] = "Logout successful!"
		redirect_to home_path
	end

end
