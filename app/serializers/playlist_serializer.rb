class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name
  has_many :songs
end
