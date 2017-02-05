FactoryGirl.define do
  factory :wiki do
    title Faker::StarWars.droid
    body Faker::StarWars.quote
    private false
    user
  end
end
