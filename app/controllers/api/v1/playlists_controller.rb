class Api::V1::PlaylistsController < ApplicationController
  # after_action :skip_authorization, only: :show

  def index
    @playlists = current_user.playlists.all
    render json: PlaylistSerializer.new(@playlists).serializable_hash.to_json
  end

  def show
    options = {}
    options[:include] = [:playlist_items]
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
             },
             status: :unprocessable_entity
    end
  end

  def update
    authorize playlist
    if playlist.update(playlist_params)
      render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
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
               error: playlist.errors.messages,
             },
             status: :unprocessable_entity
    end
  end

  private


  def playlist
    @playlist ||= Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
