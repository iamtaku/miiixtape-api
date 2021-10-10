class Api::V1::PlaylistsController < ApplicationController
  def index
    @playlists = current_user.playlists.all.sort_by(&:position)
    render json: PlaylistSerializer.new(@playlists, options).serializable_hash.to_json
  end

  def show
   # client = Rspotify.new
   # client.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
   # playlist = client::Playlist.find_by_id(playlist.id)
    render json: PlaylistSerializer.new(playlist, options).serializable_hash.to_json
  end

  def create
    playlist = Playlist.new(playlist_params)
    playlist.user = current_user
    if playlist.save
      render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
             status: :created
    else
      render json: {
               error: playlist.errors.messages,
             }, status: :unprocessable_entity
    end
  end

  def update
    authorize playlist
    if playlist.update(playlist_params)
      render json: PlaylistSerializer.new(playlist, options).serializable_hash.to_json,
             status: :ok
    else
      render json: {
               error: playlist.errors.messages,
             },
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize playlist
    if playlist.destroy
      head :no_content
    else
      render json: {
                     error: playlist.errors.messages
             },
             status: :unprocessable_entity
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :position, :editable)
  end
end
