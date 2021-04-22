class SongSerializer
  include JSONAPI::Serializer
  attributes :name, :service, :uri
  belongs_to :playlist
end
