require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @wiki = FactoryGirl.create(:wiki, user: @user)
  end

  context "admin" do

    describe "POST create" do

      it "increments Collaborator by 1" do
        expect{post :create, collaborator: {wiki_id: @wiki, user_id: @user}}.to change(Collaborator,:count).by(1)
      end

      it "assigns the collaborator to @collaborator" do
        post :create, collaborator: {wiki_id: @wiki, user_id: @user}
        expect(assigns(:collaborator)).to eq Collaborator.last
      end

      it "redirects to the wiki show view" do
        post :create, collaborator: {wiki_id: @wiki, user_id: @user}
        expect(response).to redirect_to(@wiki)
      end
    end

    describe "DELETE destroy" do

      before do
        @collaborator = FactoryGirl.create(:collaborator, wiki: @wiki, user: @user)
      end

      it "deletes the collaborator" do
        delete :destroy, wiki_id: @wiki.id, id: @collaborator.id
        count = Collaborator.where({id: @collaborator.id}).count
        expect(count).to eq 0
      end

      it "redirects to the wiki show view" do
        delete :destroy, wiki_id: @wiki.id, id: @collaborator.id
        expect(response).to redirect_to(@wiki)
      end
    end

  end

  context "premium" do

    describe "POST create" do

      it "increments Collaborator by 1" do
        expect{post :create, collaborator: {wiki_id: @wiki, user_id: @user}}.to change(Collaborator,:count).by(1)
      end

      it "assigns the collaborator to @collaborator" do
        post :create, collaborator: {wiki_id: @wiki, user_id: @user}
        expect(assigns(:collaborator)).to eq Collaborator.last
      end

      it "redirects to the wiki show view" do
        post :create, collaborator: {wiki_id: @wiki, user_id: @user}
        expect(response).to redirect_to(@wiki)
      end
    end

    describe "DELETE destroy" do

      before do
        @collaborator = FactoryGirl.create(:collaborator, wiki: @wiki, user: @user)
      end

      it "deletes the collaborator" do
        delete :destroy, wiki_id: @wiki.id, id: @collaborator.id
        count = Collaborator.where({id: @collaborator.id}).count
        expect(count).to eq 0
      end

      it "redirects to the wiki show view" do
        delete :destroy, wiki_id: @wiki.id, id: @collaborator.id
        expect(response).to redirect_to(@wiki)
      end
    end
  end

end
