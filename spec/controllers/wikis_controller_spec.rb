require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  #let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki) }

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

    it "assigns [my_wiki] to @wikis" do
      expect(assigns(:wikis)).to eq(my_wiki)
    end
  end

  describe "GET #show" do
    before do
      get :show, {id: my_wiki.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      expect(assigns(:wiki)).to eq(my_wiki)
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

   describe "PUT update" do
     before do
       new_title = Faker::StarWars.droid
       new_body = Faker::StarWars.quote
       put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
     end

     it "updates post with expected attributes" do
       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq my_wiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body
     end

     it "redirects to the updated wiki" do
       expect(response).to redirect_to my_post
     end
   end

   describe "GET edit" do
     before do
       get :edit, {id: my_wiki.id}
     end

     it "returns http success" do
       expect(response).to have_http_status(:success)
     end

     it "renders to #edit view" do
       expect(response).to render_template :edit
     end

     it "assigns wiki to be updated to @wiki" do
       wiki_instance = assigns(:wiki)
       expect(wiki_instance.id).to eq my_wiki.id
       expect(wiki_instance.title).to eq my_wiki.title
       expect(wiki_instance.body).to eq my_wiki.body
     end
   end

   describe "DELETE destroy" do
     before do
       delete :destroy, id: my_wiki.id
     end

     it "deletes the wiki" do
       count = Wiki.where({id: my_wiki.id}).size
       expect(count).to eq 0
     end

     it "redirects to wiki index" do
       expect(response).to redirect_to wikis_path
     end
   end

end
