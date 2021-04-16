class Api::V1::AuthController < ApplicationController
  # rescue_from JWT::DecodeError, with: :spotify_create
  # before_action :authenticate_user

  def create
    # if false
    query_params = {
      client_id: ENV['SPOTIFY_ID'],
      response_type: 'code',
      redirect_uri: ENV['REDIRECT_URI'],
      scope:
        'streaming user-read-email user-read-private user-read-playback-state user-modify-playback-state user-library-read user-library-modify user-top-read user-modify-playback-state playlist-modify-public playlist-modify-private ugc-image-upload user-read-recently-played ',
      show_dialog: true
    }

    url = 'https://accounts.spotify.com/authorize/'
    redirect_to "#{url}?#{query_params.to_query}"
    # end
    # end
    # puts 'jwt confirmed'
  end

  private

  def spotify_create
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
