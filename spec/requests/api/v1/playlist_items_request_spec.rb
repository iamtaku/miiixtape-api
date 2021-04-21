require 'rails_helper'

RSpec.describe 'Api::V1::PlaylistItems', type: :request do
  let(:user) { create(:user) }
  let(:playlist) { create(:playlist, user: user) }
  let(:headers) do
    { 'Authorization' => "Bearer #{AuthenticationTokenService.call(user.id)}" }
  end
  describe 'POST /items' do
    it 'creates playlistitems' do
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
      expect(
        JSON.parse(response.body)['data']['relationships']['songs']['data']
          .count
      ).to eq(5)
    end
  end
end
