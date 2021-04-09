class Api::V1::AuthController < ApplicationController
  def create
    query_params = {
      client_id: ENV['SPOTIFY_ID'],
      response_type: 'code',
      redirect_uri: ENV['REDIRECT_URI'],
      scope:
        'user-library-read user-library-modify user-top-read user-modify-playback-state playlist-modify-public playlist-modify-private ugc-image-upload user-read-recently-played',
      show_dialog: false
    }

    url = 'https://accounts.spotify.com/authorize/'
    redirect_to "#{url}?#{query_params.to_query}"
  end
end
