class Playlist < ApplicationRecord
  has_many :playlist_items, -> { order(position: :asc) }, dependent: :delete_all
  has_many :songs, through: :playlist_items

  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true
end
