require "rails_helper"

RSpec.describe "Api::V1::PlaylistItems", type: :request do
  let(:user) { create(:user) }
  let(:playlist) { create(:playlist, user: user) }
  let(:playlist_item) do
    create(:playlist_item, playlist: playlist, song: create(:song))
  end
  let(:headers) do
    { "Authorization" => "Bearer #{AuthenticationTokenService.call(user.id)}" }
  end
  let(:json) { JSON.parse(response.body) }
  describe "POST /items" do
    it "creates playlistitems" do
      songs = 5.times.map { create(:song) }
      song_params =
        songs.map do |song|
          { name: song.name, uri: song.uri, service: song.service }
        end
      params = { playlist_items: { songs: song_params } }
      post "/api/v1/playlists/#{playlist.id}/playlist_items",
           headers: headers,
           params: params
      expect(response).to have_http_status(:created)
      expect(PlaylistItem.count).to eq(5)
      expect(json["data"]["relationships"]["songs"]["data"].count).to eq(5)
    end
    
    it "does not create items when record is not editable" do
    user2 = create(:user)
       songs = 5.times.map { create(:song) }
      song_params =
        songs.map do |song|
          { name: song.name, uri: song.uri, service: song.service }
        end
      params = { playlist_items: { songs: song_params } }
      post "/api/v1/playlists/#{playlist.id}/playlist_items",
           headers: { "Authorization" => "Bearer #{AuthenticationTokenService.call(user2.id)}" },
           params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH /items" do
    it "updates a playlist item position" do
      3.times do
        create(:playlist_item, playlist: playlist, song: create(:song))
      end
      patch_params = { playlist_items: { position: 1 } }
      target = PlaylistItem.last
      patch "/api/v1/playlist_items/#{target.id}",
            headers: headers,
            params: patch_params
      expect(response).to have_http_status(:ok)
      expect(playlist.songs.first).to eq(target.song)
    end
  end

  describe "DELETE /items" do
    it "deletes a playlist item" do
      delete "/api/v1/playlist_items/#{playlist_item.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(PlaylistItem.count).to eq(0)
    end

    it "should fail when user is not authorized" do
      new_user = create(:user)
      new_headers = {
        "Authorization" => "Bearer #{AuthenticationTokenService.call(new_user.id)}",
      }
      delete "/api/v1/playlist_items/#{playlist_item.id}", headers: new_headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
