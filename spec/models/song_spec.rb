require 'rails_helper'

RSpec.describe Song, type: :model do
  subject { Song.new(name: "private video") }

  it 'should not be valid with private video a name' do
    expect(subject).to_not be_valid
  end
  

end
