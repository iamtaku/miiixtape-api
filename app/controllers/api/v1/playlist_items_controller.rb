class Api::V1::PlaylistItemsController < ApplicationController
  def create
    authorize playlist, policy_class: PlaylistItemPolicy
    new_playlist = PlaylistItem.create_multiple(playlist_items_params[:songs], playlist)
    render json: PlaylistSerializer.new(new_playlist).serializable_hash.to_json,
           status: :created
  end

  def update
    authorize playlist_item 
    if playlist_item.insert_at(position)
    options = {}
    options[:include] = [:playlist_items]
    render json: PlaylistSerializer.new(playlist_item.playlist, options).serializable_hash.to_json,
             status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    authorize playlist_item
    if playlist_item.destroy
      head :no_content
    else
      render json: {
               error: playlist_item.errors.messages,
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

  def playlist
    @playlist ||= Playlist.find(params[:playlist_id])
  end

end
