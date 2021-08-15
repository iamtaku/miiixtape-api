class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name, :editable, :position
  belongs_to :user
  has_many :playlist_items
  has_many :songs, through: :playlist_items
end
