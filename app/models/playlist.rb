class Playlist < ApplicationRecord
  before_update :insert_at
  has_many :playlist_items, -> { order(position: :asc) }, dependent: :delete_all
  has_many :songs, through: :playlist_items
  belongs_to :user
  acts_as_list scope: :user
  validates :user, presence: true
  
  private

    def insert_at position = nil
      return unless position.present?
      self.insert_at(position + 1)
    end
end
