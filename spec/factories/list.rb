FactoryBot.define do
  factory :blog do
    title {Faker::Lorem.characters(number: 10)}
    category {Faker::Lorem.characters(number: 10)}
    body {Faker::Lorem.characters(number: 30)}
  end
end