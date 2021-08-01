class User < ApplicationRecord
  has_many :playlists
  validates :spotify_id, uniqueness: true

  def token_expired?
    (Time.now - updated_at) > 3300
  end

  private

  def self.find_or_create_spotify(params)
    token ||= SpotifyManager::FetchToken.call(params)
    user_info ||= SpotifyManager::FetchUserInfo.call(token)
    user ||=
      User.find_or_create_by(
        username: user_info["display_name"],
        spotify_id: user_info["id"],
      )
    user.update(
      access_token: token["access_token"],
      refresh_token: token["refresh_token"],
    )
    raise StandardError.new "Token gone wrong" unless user.valid?
    user
  end
end
