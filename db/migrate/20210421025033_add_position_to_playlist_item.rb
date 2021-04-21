class AddPositionToPlaylistItem < ActiveRecord::Migration[6.0]
  def change
    add_column :playlist_items, :position, :integer
    # PlaylistItem.order(:updated_at).each.with_index(1) do |playlist_item, index|
    #   playlist_item.update_column :position, index
    # end
    Playlist.all.each do |playlist|
      playlist.playlist_items.order(:updated_at).each.with_index(1) do |todo_item, index|
        todo_item.update_column :position, index
      end
    end
  end
end
