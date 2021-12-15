FactoryBot.define do
  factory :user do
    # username { Faker::TvShows::Seinfeld.character }
    username { Faker::Internet.username(specifier: 5..8) }
  end
end
