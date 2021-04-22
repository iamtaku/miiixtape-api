FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user_name_#{n}" }
    sequence(:spotify_id) { |n| "spotify_id_#{n}" }
  end
end
