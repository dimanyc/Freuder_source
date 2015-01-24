class FiltersController < ApplicationController

  def new 
    @filter = Filter.new

    respond_to do |format|
      format.js{ }
    end
  end

  def create
    @filter = Filter.new(filter_params) 
    respond_to do |format|
      if @filter.save
        current_user.filters << @filter
        format.html { redirect_to user_path(current_user), notice: "Filter has been created!" }
        format.js {}
        format.json { render json: @filter, status: :created, location: @user_filters }
      else
        format.html { render :new, alert: "Problem adding your filter. Please double check your form" }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @filter = Filter.find(params[:id])
  end
  
  def destroy
    @filter = Filter.find(params[:id])
    if @filter.destroy
      flash[:notice] = "Tag has been removed"

    else
      flash[:alert] = "Problem!"
    end

    respond_to do |format|
      format.js{}
      format.html { redirect_to home_path } 
      format.json {}
    end
    
  end 

  private

  def filter_params
    params.require(:filter).permit(:name,:description,:slips,:user_id,:slipped_count)
  end


end
