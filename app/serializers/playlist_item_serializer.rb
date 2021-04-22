class PlaylistItemSerializer
  include JSONAPI::Serializer
  attributes :position, :song, :playlist
  belongs_to :playlist
  belongs_to :song
end
