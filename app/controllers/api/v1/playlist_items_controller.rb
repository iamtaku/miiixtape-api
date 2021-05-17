class Api::V1::PlaylistItemsController < ApplicationController
  before_action :authenticate_user
  before_action :authorize_user, only: %i[update destroy]
  def create
    #clean up logic for creating playlistItems and songs
    songs = playlist_items_params[:songs].map { |item| Song.create!(item) }
    playlist = Playlist.find(params[:playlist_id])
    items =
      songs.map { |item| PlaylistItem.create!(song: item, playlist: playlist) }

    render json: PlaylistSerializer.new(playlist).serializable_hash.to_json,
           status: :created
  end

  def update
    #fix update logic to so that we can reorder items
    if playlist_item.insert_at(position)
      render json:
               PlaylistItemSerializer
                 .new(playlist_item)
                 .serializable_hash
                 .to_json,
             status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
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

  def authorize_user
    return authentication_error unless playlist_item.user == @user
  end

  def playlist_item
    @playlist_item ||= PlaylistItem.find(params[:id])
  end

  def playlist_items_params
    params
      .require(:playlist_items)
      .permit(:position, songs: %i[name uri service])
  end

  def position
    playlist_items_params[:position].to_i
  end
end
