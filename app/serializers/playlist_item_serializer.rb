class PlaylistItemSerializer
  include JSONAPI::Serializer
  attributes :position, :song
  belongs_to :playlist
  belongs_to :song
end
