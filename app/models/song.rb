class Song < ApplicationRecord
  has_many :playlist_items
  has_many :playlists, through: :playlist_items
  validates :name, :service, :uri, presence: true
end
