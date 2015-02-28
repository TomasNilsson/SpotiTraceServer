class Api::LocationsController < Api::ApiController
  before_action :set_location, only: [:destroy] 
  
  def create
    @location = Location.where(user_id: @user.id).first_or_initialize
    @location.assign_attributes(location_params)
    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # TODO: Destroy if location is old
  def destroy
    if @location.destroy
      render json: { status: :ok }
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  private
     def set_location
       @location = Location.find(params[:id])
     end

     def location_params
      params.require(:location).permit(:latitude, :longitude)
     end

end
