require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user, email: "wikiuser1@email.com" ) }
  let(:wiki) { Wiki.create!(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!", private: false, user_id: user.id) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!")
     end
   end
end
