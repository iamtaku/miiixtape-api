class Api::V1::UsersController < ApplicationController
  before_action :check_access
  before_action :authenticate_user, only: [:index]

  def create
    # render jwt is successfull
    render json: { token: AuthenticationTokenService.call(user.id) }
  end

  def index
    # render spotify tokens for user if valid jwt
    if @user.token_expired?
      token = SpotifyManager::RefreshToken.call(@user.refresh_token)
      @user.update(access_token: token)
    end

    render json: UserSerializer.new(@user).serializable_hash.to_json,
           status: :ok
  end

  private

  def check_access
    if params[:error] == 'access_denied'
      redirect_to 'http://localhost:3001/error'
    end
  end
end
