class PlaylistItem < ApplicationRecord
  belongs_to :playlist, optional: true
  belongs_to :song
  delegate :user, to: :playlist, allow_nil: true
  validates :song, :playlist, presence: true
  acts_as_list scope: :playlist
end
