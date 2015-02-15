class Api::SongsController < Api::ApiController
  before_action :set_song, only: [:show, :update, :destroy] 

  def index
    @songs = Song.all
    render json: @songs
  end

  def show
    render json: @song
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      render json: @song, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @song.update_attributes(song_params)
      render json: { status: :ok }
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
      params.require(:song).permit(:name, :artist, :album, :uri, :image_url)
     end

end
