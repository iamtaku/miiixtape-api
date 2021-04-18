require 'rails_helper'

RSpec.describe Playlist, type: :model do
  let(:user) { create(:user) }
  subject { Playlist.new }

  it 'should not be valid without a name' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user = user
    subject.name = 'test playlist'
    expect(subject).to be_valid
  end
end
