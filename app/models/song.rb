class Song < ApplicationRecord
  has_many :playlist_items
  has_many :playlists, through: :playlist_items
  validates :name, :service, :uri, presence: true
  validates :uri, uniqueness: true

  def self.find_or_create_by_uri(item)
    song = Song.find_by uri: item["uri"]
    return song unless song.nil?
    Song.create(name: item["name"], uri: item["uri"], service: item["service"])
  end
end
