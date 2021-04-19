FactoryBot.define do
  factory :playlist do
    sequence(:name) { |n| "playlist_#{n}" }
  end
end
