require 'rails_helper'

RSpec.describe 'Api::V1::Playlists', type: :request do
  let(:user) { create(:user) }
  let(:token) { AuthenticationTokenService.call(user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:name) { 'test playlist' }
  let(:params) { { playlist: { name: name, user_id: user.id } } }
  let(:playlist) { create(:playlist, user: user) }

  # let(:playlist_items) { create(:playlist_items, playlist: playlist, song: song)}

  describe 'GET /playlist' do
    it 'returns all playlists' do
      3.times { create(:playlist, user: user) }
      get '/api/v1/playlists', headers: headers
      JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].count).to eq(3)
    end

    it 'fails when no headers' do
      get '/api/v1/playlists'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /playlists' do
    it 'creates new playlists' do
      post '/api/v1/playlists', headers: headers, params: params

      expect(response).to have_http_status(:created)
      expect(Playlist.count).to eq(1)
      expect(JSON.parse(response.body)['data']['attributes']['name']).to eq(
        name
      )
    end

    it 'fails when parameters are missing' do
      post '/api/v1/playlists', headers: headers
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'PATCH /playlists' do
    it 'updates a playlist' do
      updated_name = 'updated name'
      updated_params = { playlist: { name: updated_name, user_id: user.id } }
      patch "/api/v1/playlists/#{playlist.id}",
            headers: headers,
            params: updated_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['attributes']['name']).to eq(
        updated_name
      )
    end

    it 'fails when id is wrong' do
      patch "/api/v1/playlists/#{playlist.id}1", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /playlists' do
    it 'deletes a playlist' do
      delete "/api/v1/playlists/#{playlist.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Playlist.count).to eq(0)
    end
  end
end
