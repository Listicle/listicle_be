FactoryBot.define do
  factory :user do
    username { Faker::TvShows::Seinfeld.character }
  end
end
