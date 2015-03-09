class Api::UsersController < Api::ApiController
  skip_before_filter :restrict_access, only: [:create]

  def create
    @user = User.where(username: params[:user][:username]).first_or_initialize
    @user.token = params[:user][:token]
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  def nearby
    #@user.location.nearbys(30).as_json(only: :distance, include: { user: { only: [:id, :username], include: :song } } ) # Other users within 30 km
    distance = params[:distance] ||= 30
    @nearby_locations = @user.location.nearbys(distance).reject { |location| location.user.song.blank? } # Other locations within params[:distance] km
    # See app/views/api/users/nearby.json.jbuilder
  end

  def location
    latitude = params[:latitude]
    longitude = params[:longitude]
    distance_from_location = 30
    @nearby_locations = Location.near([latitude, longitude], distance_from_location).reject { |location| location.user.song.blank? } # Other locations within distance_from_location km
    @my_location = @user.location
  end

  def master_user
    @user.master_user_id = params[:id]
    if @user.save
      render json: { status: :ok }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  def master_user_remove
    @user.master_user_id = nil
    if @user.save
      render json: { status: :ok }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
     def set_user
       @user = User.find(params[:id])
     end

     def user_params
      params.require(:user).permit(:username, :token)
     end

end
