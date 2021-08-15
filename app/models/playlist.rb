class Playlist < ApplicationRecord
  has_many :playlist_items, -> { order(position: :asc) }, dependent: :delete_all
  has_many :songs, through: :playlist_items
  belongs_to :user
  acts_as_list scope: :user, top_of_list: 0
  validates :user, presence: true
  

end
