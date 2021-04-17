class Playlist < ApplicationRecord
  has_many :songs
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true
end
