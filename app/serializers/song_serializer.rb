class SongSerializer
  include JSONAPI::Serializer
  attributes :name, :service, :uri
end
