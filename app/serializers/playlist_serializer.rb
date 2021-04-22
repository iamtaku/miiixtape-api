class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name
  has_many :songs, serializer: SongSerializer
  # has_many :playlist_items
  # attribute :song_items do |playlist|
  #   playlist.songs.each do |song|

  #   end
  # end
end
