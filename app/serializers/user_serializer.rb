class UserSerializer
  include JSONAPI::Serializer

  attributes :username, :spotify_id, :access_token, :refresh_token
  attribute :id do |user|
    AuthenticationTokenService.call(user.id)
  end
end
