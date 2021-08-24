class PlaylistItem < ApplicationRecord
  belongs_to :playlist, optional: true
  belongs_to :song
  delegate :user, to: :playlist, allow_nil: true
  validates :song, :playlist, presence: true
  acts_as_list scope: :playlist, top_of_list: 0
  
  def self.create_multiple songs, playlist
    songs.each do |item|
      self.create!(song: Song.find_or_create_by_uri(item), playlist: playlist)
    end
    playlist
  end
end
