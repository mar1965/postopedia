require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_wiki) { create(:wiki, user:my_user) }

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @wiki = FactoryGirl.create(:wiki, user: @user)
  end

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns wiki to @wikis" do
      expect(assigns(:wikis)).to eq(@wiki)
    end
  end

  describe "GET #show" do
    before do
      get :show, {id: @wiki.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end

    it "assigns wiki to @wiki" do
      expect(assigns(:wiki)).to eq(@wiki)
    end
  end

  describe "GET #new" do
    before do
      get :new
    end

     it "returns http success" do
       expect(response).to have_http_status(:success)
     end

     it "renders the #new view" do
       expect(response).to render_template :new
     end

     it "instantiates @wiki" do
       expect(assigns(:wiki)).not_to be_nil
     end
   end

   describe "POST create" do
     it "increments Wiki by 1" do
       expect{wiki :create, wiki: {title: Faker::StarWars.droid, body: Faker::StarWars.quote}}.to change(Wiki,:count).by(1)
     end

     before do
       wiki :create, wiki: {title: Faker::StarWars.droid, body: Faker::StarWars.quote}
     end

     it "assigns the new wiki to @wiki" do
       expect(assigns(:wiki)).to eq Wiki.last
     end

     it "redirects to the new wiki" do
       expect(response).to redirect_to Wiki.last
     end
   end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit, {id: @wiki.id}
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
