require 'rails_helper'

RSpec.describe Wiki, type: :model do
  #let(:wiki) { Wiki.create!(title: Faker::StarWars.droid, body: Faker::StarWars.quote, private: false) }
  let(:wiki) { create(:wiki) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: Faker::StarWars.droid, body: Faker::StarWars.quote)
     end
   end
end
