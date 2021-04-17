class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :name
      t.string :service
      t.references :playlist, null: true, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
