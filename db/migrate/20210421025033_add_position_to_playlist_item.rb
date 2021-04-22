class AddPositionToPlaylistItem < ActiveRecord::Migration[6.0]
  def change
    add_column :playlist_items, :position, :integer
    Playlist.all.each do |playlist|
      playlist
        .playlist_items
        .order(:updated_at)
        .each
        .with_index(1) do |playlist_item, index|
          playlist_item.update_column :position, index
        end
    end
  end
end
