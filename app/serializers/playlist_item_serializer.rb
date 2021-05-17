class PlaylistItemSerializer
  include JSONAPI::Serializer
  attributes :position
  belongs_to :playlist
  belongs_to :song
end
