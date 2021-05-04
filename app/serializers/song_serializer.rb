class SongSerializer
  include JSONAPI::Serializer
  attributes :name, :service, :uri
  has_many :playlist_items
end
