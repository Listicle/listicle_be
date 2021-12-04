FactoryBot.define do
  factory :project do
    project_name { Faker::Lorem.sentence }
    user { 1 }
  end
end
