class Api::V1::UsersController < ApplicationController
  before_action :check_access

  def create
    # render json: {
    #          token: AuthenticationTokenService.call(user.id),
    #          user: {
    #            username: user.username,
    #            access_token: user.access_token,
    #            refresh_token: user.refresh_token
    #          }
    #        }
    render json: UserSerializer.new(user).serializable_hash.to_json
  end

  def index
    @user = User.find(params[:id])
    render json: { user: @user }
  end

  private

  def check_access
    if params[:error] == 'access_denied'
      redirect_to 'http://localhost:3001/error'
    end
  end
end
