class ApplicationController < ActionController::API
  rescue_from JWT::VerificationError,
              JWT::DecodeError,
              with: :authentication_error

  rescue_from ActionController::ParameterMissing,
              with: :handle_parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include ActionController::HttpAuthentication::Token
  include Pundit


  private

  def playlist
    @playlist ||= Playlist.find(params[:id])
  end
  
  def handle_parameter_missing(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def spotify_user
    @spotify_user ||= User.find_or_create_spotify(params)
  end
  
  def current_user
    token, _options = token_and_options(request)
    # return nil if token.nil?
    user_id = AuthenticationTokenService.decode(token)
    @user ||= User.find(user_id)
  end

  def authentication_error
    render json: {error: "token gone wrong "}, status: :unauthorized
  end

  def not_found
    render json: { error: "user not found" }, status: :not_found
  end
  
  def user_not_authorized
    render json: { error: "You are not authorized for this action"}, status: :unauthorized
  end

end
