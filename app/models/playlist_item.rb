class PlaylistItem < ApplicationRecord
  belongs_to :playlist
  belongs_to :song
  validates :song, :playlist, presence: true
  acts_as_list scope: :playlist
end
