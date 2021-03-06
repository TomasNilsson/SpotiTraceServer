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

  def show
    @my_location = @user.location
    @other_user = User.find(params[:id])
    # See app/views/api/users/show.json.jbuilder
  end
  
  def nearby
    #@user.location.nearbys(30).as_json(only: :distance, include: { user: { only: [:id, :username], include: :song } } ) # Other users within 30 km
    distance = params[:distance] ||= 30
    @nearby_locations = @user.location.nearbys(distance).limit(25).reject { |location| location.user.song.blank? } # 25 closest locations within params[:distance] km
    # See app/views/api/users/nearby.json.jbuilder
  end

  def location
    latitude = params[:latitude]
    longitude = params[:longitude]
    distance_from_location = 30
    # 25 closest locations within distance_from_location km
    @nearby_locations = Location.near([latitude, longitude], distance_from_location).limit(25).reject { |location| location.user.song.blank? || location.user.id == @user.id }
    @my_location = @user.location
    # See app/views/api/users/location.json.jbuilder
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

  def followers
    @followers = @user.followers
    # See app/views/api/users/followers.json.jbuilder
  end

  private
     def set_user
       @user = User.find(params[:id])
     end

     def user_params
      params.require(:user).permit(:username, :token)
     end

end
