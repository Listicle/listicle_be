FactoryBot.define do
  factory :activity do
    title { Faker::Lorem.word }
    project { 1 }
    status { Faker::Number.between(from: 0, to: 2) }
  end
end
