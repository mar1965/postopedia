require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:@user) { create(:user, email: "wikiuser@email.com") }
  let(:@my_wiki) { create(:wiki, user: @user) }
  let(:@my_private_wiki) { create(:wiki, private: true, user: @user) }

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @wiki = FactoryGirl.create(:wiki, user: @user)
  end

  context "standard" do
    describe "GET #index" do
      before do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "does not include private wikis in @wikis" do
        expect(assigns(:@wikis)).not_to eq(@my_private_wiki)
      end
    end
  end

  context "premium" do
    describe "GET #index" do
      before do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to wiki" do
        expect(assigns(:@wikis)).to eq(@my_private_wiki)
      end
    end
  end


  context "admin" do
    describe "GET #index" do
      before do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to wiki" do
        expect(assigns(:@wikis)).to eq(@my_private_wiki)
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

      it "assigns @wiki to @wiki" do
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
         expect{post :create, wiki: {title: Faker::StarWars.droid, body: Faker::StarWars.quote}}.to change(Wiki,:count).by(1)
       end

       it "assigns the new wiki to @wiki" do
         post :create, wiki: {title: Faker::StarWars.droid, body: "something!!!!!!!!!!!!!!!!!"}
         expect(assigns(:wiki)).to eq Wiki.first
       end

       it "redirects to the new wiki" do
         post :create, wiki: {title: Faker::StarWars.droid, body: Faker::StarWars.quote}
         expect(response).to redirect_to Wiki.first
       end
     end

     describe "PUT update" do
       before do
         @new_title = Faker::StarWars.droid
         @new_body = Faker::StarWars.quote
         put :update, id: @wiki.id, wiki: {title: @new_title, body: @new_body}
       end

       it "updates wiki with expected attributes" do
         updated_wiki = assigns(:wiki)
         expect(updated_wiki.id).to eq @wiki.id
         expect(updated_wiki.title).to eq @new_title
         expect(updated_wiki.body).to eq @new_body
       end

       it "redirects to the updated wiki" do
         expect(response).to redirect_to @wiki
       end
     end

     describe "GET edit" do
       before do
         get :edit, {id: @wiki.id}
       end

       it "returns http success" do
         expect(response).to have_http_status(:success)
       end

       it "renders to #edit view" do
         expect(response).to render_template :edit
       end

       it "assigns wiki to be updated to @wiki" do
         wiki_instance = assigns(:wiki)
         expect(wiki_instance.id).to eq @wiki.id
         expect(wiki_instance.title).to eq @wiki.title
         expect(wiki_instance.body).to eq @wiki.body
       end
     end

     describe "DELETE destroy" do
       before do
         delete :destroy, {id: @wiki.id}
       end

       it "deletes the wiki" do
         count = Wiki.where({id: @wiki.id}).size
         expect(count).to eq 0
       end

       it "redirects to wiki index" do
         expect(response).to redirect_to wikis_path
       end
     end
  end

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns [@wiki] to @wikis" do
      expect(assigns(:wikis).first).to eq(@wiki)
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

    it "assigns @wiki to @wiki" do
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
       expect{post :create, wiki: {title: Faker::StarWars.droid, body: Faker::StarWars.quote}}.to change(Wiki,:count).by(1)
     end

     it "assigns the new wiki to @wiki" do
       post :create, wiki: {title: Faker::StarWars.droid, body: "something!!!!!!!!!!!!!!!!!"}
       expect(assigns(:wiki)).to eq Wiki.first
     end

     it "redirects to the new wiki" do
       post :create, wiki: {title: Faker::StarWars.droid, body: Faker::StarWars.quote}
       expect(response).to redirect_to Wiki.first
     end
   end

   describe "PUT update" do
     before do
       @new_title = Faker::StarWars.droid
       @new_body = Faker::StarWars.quote
       put :update, id: @wiki.id, wiki: {title: @new_title, body: @new_body}
     end

     it "updates wiki with expected attributes" do
       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq @wiki.id
       expect(updated_wiki.title).to eq @new_title
       expect(updated_wiki.body).to eq @new_body
     end

     it "redirects to the updated wiki" do
       expect(response).to redirect_to @wiki
     end
   end

   describe "GET edit" do
     before do
       get :edit, {id: @wiki.id}
     end

     it "returns http success" do
       expect(response).to have_http_status(:success)
     end

     it "renders to #edit view" do
       expect(response).to render_template :edit
     end

     it "assigns wiki to be updated to @wiki" do
       wiki_instance = assigns(:wiki)
       expect(wiki_instance.id).to eq @wiki.id
       expect(wiki_instance.title).to eq @wiki.title
       expect(wiki_instance.body).to eq @wiki.body
     end
   end

   describe "DELETE destroy" do
     before do
       delete :destroy, {id: @wiki.id}
     end

     it "deletes the wiki" do
       count = Wiki.where({id: @wiki.id}).size
       expect(count).to eq 0
     end

     it "redirects to wiki index" do
       expect(response).to redirect_to wikis_path
     end
   end

end
