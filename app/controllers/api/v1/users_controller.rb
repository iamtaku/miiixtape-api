class Api::V1::UsersController < ApplicationController
  def create
    if params[:error]
      render json: {
               error: 'spotify authorization failed'
             },
             status: :unauthorized
    end

    options = {
      body: {
        grant_type: 'authorization_code',
        code: params[:code],
        redirect_uri: 'http://localhost:3001/callback',
        client_id: ENV['SPOTIFY_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }
    }
    auth_response =
      HTTParty.post('https://accounts.spotify.com/api/token', options)

    # convert response.body to json for assisgnment
    auth_params = JSON.parse(auth_response.body)
    redirect_to 'http://localhost:3001/callback'

    header = { Authorization: "Bearer #{auth_params['access_token']}" }
    user_response =
      HTTParty.get('https://api.spotify.com/v1/me', { headers: header })

    # convert response.body to json for assisgnment
    p user_params = JSON.parse(user_response.body)

    # render json: user_params
    # Create new user based on response, or find the existing user in database
    # byebug
    @user =
      User.find_or_create_by(
        username: user_params['display_name'],
        # spotify_url: user_params["external_urls"]["spotify"],
        # href: user_params["href"],
        # spotify_uri: user_params["uri"])
        spotify_id: user_params['id']
      )
    p @user

    # render json: @user
  end
end
