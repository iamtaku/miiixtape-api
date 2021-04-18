class CreatePlaylistItems < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_items, id: :uuid do |t|
      t.references :song,
                   null: true,
                   type: :uuid,
                   foreign_key: true,
                   index: true
      t.references :playlist,
                   null: true,
                   type: :uuid,
                   foreign_key: true,
                   index: true
      t.timestamps
    end
  end
end
