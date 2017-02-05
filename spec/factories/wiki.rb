FactoryGirl.define do
  factory :wiki do
    #title Faker::Hipster.sentence(4)
    #body Faker::Hipster.paragraph(5)
    title Faker::StarWars.droid
    body Faker::StarWars.quote
    private false
    user
  end
end
