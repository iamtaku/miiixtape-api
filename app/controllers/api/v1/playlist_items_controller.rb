class Api::V1::PlaylistItemsController < ApplicationController
  before_action :authenticate_user
  def create
    songs = playlist_items_params[:songs].map { |item| Song.create!(item) }
    playlist = Playlist.find(params[:playlist_id])
    items =
      songs.map { |item| PlaylistItem.create!(song: item, playlist: playlist) }

    p render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
             status: :created
  end

  private

  def playlist_items_params
    params.require(:playlist_items).permit(songs: %i[name uri service])
  end
end
