require 'rails_helper'

RSpec.describe Playlist, type: :model do
  let(:user) { create(:user) }
  subject { Playlist.new }

  it 'should not be valid without a name' do
    expect(subject).to_not be_valid
  end

  it 'is valid with validattributes' do
    subject.user = user
    subject.name = 'test playlist'
    expect(subject).to be_valid
  end
  
  it 'should be able to update the position of a playlist' do
    3.times { create(:playlist, user: user)}
    target = Playlist.last
    target.update(position: 0)
    expect(user.playlists.first).to eq(target)
  end
end
