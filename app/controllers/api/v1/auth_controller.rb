class Api::V1::AuthController < ApplicationController
  # rescue_from JWT::DecodeError, with: :spotify_create
  # before_action :authenticate_user

  def create
    redirect_to SpotifyManager::GetScope.call
  end
end
