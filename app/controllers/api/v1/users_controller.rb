class Api::V1::UsersController < ApplicationController
  before_action :check_access

  # before_action :fetch_token
  def create
    user = find_user(fetch_token)

    render json: {
             token: AuthenticationTokenService.call(user.id),
             user: {
               username: user.username,
               access_token: user.access_token,
               refresh_token: user.refresh_token
             }
           }
  end

  def index
    @user = User.find(params[:id])
    render json: { user: @user }
  end

  private

  def fetch_token
    options = {
      body: {
        grant_type: 'authorization_code',
        code: params[:code],
        redirect_uri: ENV['REDIRECT_URI'],
        client_id: ENV['SPOTIFY_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }
    }
    auth_response =
      HTTParty.post('https://accounts.spotify.com/api/token', options)

    # convert response.body to json for assisgnment
    @auth_params = JSON.parse(auth_response.body)
  end

  def check_access
    if params[:error] == 'access_denied'
      # render json: {
      #          error: 'spotify authorization failed'
      #        },
      #        status: :unauthorized
      redirect_to 'http://localhost:3001/error'
    end
  end
end
