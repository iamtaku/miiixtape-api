class Api::V1::PlaylistItemsController < ApplicationController
  before_action :authenticate_user
  def create
    #clean up logic for creating playlistItems and songs
    songs = playlist_items_params[:songs].map { |item| Song.create!(item) }
    playlist = Playlist.find(params[:playlist_id])
    items =
      songs.map { |item| PlaylistItem.create!(song: item, playlist: playlist) }

    p render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
             status: :created
  end

  def destroy
    return authentication_error unless playlist_item.playlist.user == @user

    if playlist_item.destroy
      head :no_content
    else
      render json: {
               error: playlist_item.errors.messages
             },
             status: :unprocessable_entity
    end
  end

  private

  def playlist_item
    @playlist_item ||= PlaylistItem.find(params[:id])
  end

  def playlist_items_params
    params.require(:playlist_items).permit(songs: %i[name uri service])
  end
end
