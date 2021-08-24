class AddPositionToPlaylist < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :position, :integer
    User.all.each do |user|
      user.playlists.order(:updated_at).each.with_index(1) do |playlist, index|
        playlist.update_column :position, index
      end
    end
  end
end
