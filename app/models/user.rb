class User < ApplicationRecord
  private

  def self.find_or_create_spotify(params)
    token = SpotifyManager::FetchToken.call(params)
    user_params = SpotifyManager::FetchUserInfo.call(token)
    @user =
      User.find_or_create_by(
        username: user_params['display_name'],
        spotify_id: user_params['id']
      )
    @user.update(
      access_token: token['access_token'],
      refresh_token: token['refresh_token']
    )
    @user
  end
end
