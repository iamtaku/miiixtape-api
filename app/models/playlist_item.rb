class PlaylistItem < ApplicationRecord
  belongs_to :playlist
  belongs_to :song
  validates :song, :playlist, presence: true
end
