FactoryBot.define do
  factory :song do
    sequence(:name) { |n| "test song #{n}" }
    service { 'spotify' }
  end
end
