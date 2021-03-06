class Api::FriendshipsController < Api::ApiController

  def create
    @friendship = @user.friendships.where(friend_id: params[:id]).first_or_initialize
    if @friendship.save
      render json: @friendship, status: :created
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end
  
  def index
    @friends = @user.friends.order(:username)
    # See app/views/api/friendships/index.json.jbuilder
  end

  def remove
    @friendship = @user.friendships.where(friend_id: params[:id]).first
    if @friendship.destroy
      render json: { status: :ok }
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

end
