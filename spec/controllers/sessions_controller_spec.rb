require 'rails_helper'


RSpec.describe SessionsController , :type => :controller do

  describe 'POST #create' do
    context "with valid auth_hash" do
      before do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:default]
      end

      it "should successfully create a user" do
        expect {
          post :create , :provider => :developer
        }.to change { User.count }.by 1
      end

      it "should successfully create a session" do
        (expect session[:user_id]).to     be_nil
        post :create , :provider => :developer
        (expect session[:user_id]).not_to be_nil
      end

      it "should assign @current_user" do
        post :create , :provider => :developer
        (expect assigns :current_user).not_to be_nil
      end

      it "should redirect to the home page" do
        post :create , :provider => :developer
        (expect response).to redirect_to root_url
        (expect flash[:notice]).to eq "Signed in"
      end
    end

    context "with invalid auth_hash" do
      before do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:nfg]
      end

      it "should invalidate login session" do
        post :create , :provider => :default
        (expect session[:user_id]).to be_nil
      end

      it "should invalidate @current_user" do
        post :create , :provider => :default
        (expect assigns :current_user).to be_nil
      end

      it "should redirect to the home page" do
        post :create , :provider => :default
        (expect response).to redirect_to root_url
        (expect flash[:notice]).to eq "Error signing in"
      end
    end

    context "with duplicated nick" do
    end

    context "with duplicated uid" do
    end
  end

  describe 'GET #destroy' do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:default]
      post :create , :provider => :default
    end

    it "should clear the session" do
      (expect session[:user_id]).not_to be_nil
      get :destroy
      (expect session[:user_id]).to     be_nil
    end

    it "should redirect to the home page" do
      get :destroy
      (expect response).to redirect_to root_url
      (expect flash[:notice]).to eq "Signed out"
    end
  end

end
