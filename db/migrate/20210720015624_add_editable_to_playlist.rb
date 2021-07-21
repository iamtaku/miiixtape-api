class AddEditableToPlaylist < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :editable, :boolean, :default => false
  end
end
