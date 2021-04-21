FactoryBot.define do
  factory :song do
    sequence(:name) { |n| "test song #{n}" }
    sequence(:uri) { |n| "song_uri_#{n}" }
    service { 'spotify' }
  end
end
