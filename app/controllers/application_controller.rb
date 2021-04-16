class ApplicationController < ActionController::API
  rescue_from JWT::VerificationError,
              JWT::DecodeError,
              ActiveRecord::RecordNotFound,
              with: :authentication_error
  include ActionController::HttpAuthentication::Token

  private

  def find_user(auth_params)
    header = { Authorization: "Bearer #{auth_params['access_token']}" }
    user_response =
      HTTParty.get('https://api.spotify.com/v1/me', { headers: header })

    # convert response.body to json for assisgnment
    user_params = JSON.parse(user_response.body)

    @user =
      User.find_or_create_by(
        username: user_params['display_name'],
        spotify_id: user_params['id']
      )
    @user.update(
      access_token: auth_params['access_token'],
      refresh_token: auth_params['refresh_token']
    )
    @user
  end

  def authenticate_user
    # Authorization: Bearer <token>
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)

    @user = User.find(user_id)
  end

  def authentication_error
    render status: :unauthorized
  end
end
