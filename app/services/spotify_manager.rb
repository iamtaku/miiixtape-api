module SpotifyManager
  class GetScopeURL
    def self.call
      query_params = {
        client_id: ENV["SPOTIFY_ID"],
        response_type: "code",
        redirect_uri: ENV["REDIRECT_URI"],
        scope: "streaming user-read-email user-read-private user-read-playback-state user-modify-playback-state user-library-read user-library-modify user-top-read user-modify-playback-state playlist-modify-public playlist-modify-private ugc-image-upload user-read-recently-played ",
        show_dialog: false,
      }

      url = "https://accounts.spotify.com/authorize"
      "#{url}/?#{query_params.to_query}"
    end
  end

  class FetchToken
    def self.call(params)
      options = {
        body: {
          grant_type: "authorization_code",
          code: params[:code],
          redirect_uri: ENV["REDIRECT_URI"],
          client_id: ENV["SPOTIFY_ID"],
          client_secret: ENV["SPOTIFY_CLIENT_SECRET"],
        },
      }
      auth_response =
        HTTParty.post("https://accounts.spotify.com/api/token", options)

      # convert response.body to json for assisgnment
      p JSON.parse(auth_response.body)
    end
  end

  class FetchUserInfo
    def self.call(auth_params)
      header = { Authorization: "Bearer #{auth_params["access_token"]}" }
      user_response =
        HTTParty.get("https://api.spotify.com/v1/me", { headers: header })

      # convert response.body to json for assisgnment
      JSON.parse(user_response.body)
    end
  end

  class RefreshToken
    def self.call(refresh_token)
      options = {
        body: {
          grant_type: "refresh_token",
          refresh_token: refresh_token,
          client_id: ENV["SPOTIFY_ID"],
          client_secret: ENV["SPOTIFY_CLIENT_SECRET"],
        },
      }

      auth_response =
        HTTParty.post("https://accounts.spotify.com/api/token", options)
      JSON.parse(auth_response.body)["access_token"]
    end
  end
end
