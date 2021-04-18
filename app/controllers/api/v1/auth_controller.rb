class Api::V1::AuthController < ApplicationController
  def create
    url = SpotifyManager::GetScopeURL.call
    redirect_to url
  end
end
