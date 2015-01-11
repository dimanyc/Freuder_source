class FiltersController < ApplicationController

	def new 
		@filter = Filter.new
	end

	def create
		@filter = Filter.new(filter_params) 
		respond_to do |format|
			if @filter.save
				current_user.filters << @filter
				format.html { redirect_to user_path(current_user), notice: 'Filter has been created!' }
			else
				format.html {render :new,alert: "Problem adding your filter. Please double check your form"}
				format.json {render json: @filter.errors, status: :unprocessable_entity}
			end
		end
	end

	def show
		@user = current_user
		@filter = Filter.find(params[:id])
	end

	private

	def filter_params
		params.require(:filter).permit(:name,:description)
	end


end
