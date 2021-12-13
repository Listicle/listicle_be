FactoryBot.define do
  factory :task do
    task_name { Faker::Verb.base }
    completed { true }
    activity { 1 }
  end
end
