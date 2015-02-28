class Api::SongsController < Api::ApiController
  before_action :set_song, only: [:destroy] 

  # TODO: remove Song index and replace it by get_nearby_users (and songs) in the UsersController
  def index
    @songs = Song.all.order(:user_id)
    render json: @songs
  end

  def create
    @song = Song.where(user_id: @user.id).first_or_initialize
    @song.assign_attributes(song_params)
    if @song.save
      render json: @song, status: :created
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @song.destroy
      render json: { status: :ok }
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  private
     def set_song
       @song = Song.find(params[:id])
     end

     def song_params
      params.require(:song).permit(:name, :artist, :uri, :image_url)
     end

end
