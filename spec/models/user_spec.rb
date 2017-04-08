require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, email: "wikiuser@email.com" ) }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to have_many(:collaborators) }

  # Shoulda tests for email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value("wikiuser@email.com").for(:email) }

  # Shoulda tests for encrypted password
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have an email" do
      expect(user).to have_attributes(email: user.email)
    end

    it "responds to email" do
      expect(user).to respond_to(:email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to standard" do
      expect(user).to respond_to(:standard?)
    end

    it "responds to premium" do
      expect(user).to respond_to(:premium?)
    end
  end

  describe "roles" do

    it "is standard by default" do
      expect(user.role).to eq("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
    end

    context "premium user" do
      before do
        user.premium!
      end

      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end
  end
end
