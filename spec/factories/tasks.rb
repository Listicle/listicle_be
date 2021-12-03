FactoryBot.define do
  factory :task do
    task_name { "MyString" }
    status { false }
    activity { nil }
  end
end
