require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user, email: "wikiuser1@email.com" ) }
  let(:wiki) { Wiki.create!(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!", private: false, user_id: user.id) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!")
    end
  end

  describe "scopes" do
    before do
      @public_wiki = Wiki.create!(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!", private: false, user_id: user.id)
      @private_wiki = Wiki.create!(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!", private: true, user_id: user.id)
    end

    describe "visible_to(user)" do
      it "returns all wikis if the user is present" do
        user = User.new
        expect(Wiki.visible_to(user)).to eq(Wiki.all)
      end

      it "returns only public wikis if user is nil" do
        expect(Wiki.visible_to(nil)).to eq([@public_wiki])
      end
    end
  end
end
