class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :name
      t.string :service
      t.string :uri

      t.timestamps
    end
  end
end
