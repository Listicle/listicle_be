FactoryBot.define do
  factory :task do
    task_name { Faker::Verb.base }
    completed { Faker::Boolean.boolean }
    activity { 1 }
  end
end
