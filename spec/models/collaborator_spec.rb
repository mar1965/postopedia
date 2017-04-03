require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user, email: "wikiuser@email.com" ) }
  let(:wiki) { Wiki.create!(title: "Wiki Title Wiki Wiki", body: "This is my wiki body. This wiki is nice!", private: false, user_id: user.id) }
  let(:collaborator) { Collaborator.create!(wiki: wiki_id, user: user_id) }


  it { is_expected.to belong_to(:wiki) }
  it { is_expected.to belong_to(:user) }
end
