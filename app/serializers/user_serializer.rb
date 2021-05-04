class UserSerializer
  include JSONAPI::Serializer

  attributes :username, :spotify_id, :access_token, :refresh_token
  has_many :playlists, serializer: PlaylistSerializer
end
