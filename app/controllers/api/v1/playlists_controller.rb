class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_user, only: %i[update destroy]

  def index
    # need user and render all playlists
    playlists = @user.playlists.all
    render json: PlaylistSerializer.new(playlists).serializable_hash.to_json
  end

  def create
    # byebug
    playlist = Playlist.new(playlist_params)
    if playlist.save
      render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
             status: :created
    else
      render json: {
               error: playlist.errors.messages
             },
             status: :unprocessable_entity
    end
  end

  def update
    # byebug
    if playlist.update(playlist_params)
      render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
             status: :ok
    else
      render json: {
               error: playlist.errors.messages
             },
             status: :unprocessable_entity
    end
  end

  def destroy
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

  def authorize_user
    return authentication_error unless playlist.user == @user
  end

  def playlist
    @playlist ||= Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :user_id)
  end
end
