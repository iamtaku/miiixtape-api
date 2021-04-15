class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username
      t.string :access_token
      t.string :refresh_token
      t.string :spotify_id

      t.timestamps
    end
  end
end
