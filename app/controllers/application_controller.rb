class ApplicationController < ActionController::API
  rescue_from JWT::VerificationError,
              JWT::DecodeError,
              with: :authentication_error

  rescue_from ActionController::ParameterMissing,
              with: :handle_parameter_missing
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  include ActionController::HttpAuthentication::Token

  private

  def handle_parameter_missing(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def current_user
    @current_user ||= User.find_or_create_spotify(params)
  end

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    @user = User.find(user_id)
  end

  def authentication_error
    render status: :unauthorized
  end

  def not_found
    render status: :not_found
  end
end
