class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name
  # has_many :songs, serializer: SongSerializer
  has_many :playlist_items
  has_many :songs, through: :playlist_items
end
