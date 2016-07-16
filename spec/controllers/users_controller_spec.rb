require 'rails_helper'

RSpec.describe UsersController , :type => :controller do

  let(:valid_attributes  ) { { :nick => 'a-nick'       , :bio => 'A bio.' } }
  let(:valid_attributes2 ) { { :nick => 'another-nick' , :bio => 'Another bio.' } }
  let(:invalid_attributes) { { :nick => nil } }
  let(:valid_session     ) { {} }

  describe 'GET #index' do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index , :params => {} , :session => valid_session
      (expect assigns :users).to eq [user]
    end
  end

  describe 'GET #new' do
    it "assigns a new user as @user" do
      get :new , :params => {} , :session => valid_session
      (expect assigns :user).to be_a_new User
    end
  end

  describe 'GET #show' do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show , :nick => user.nick , :session => valid_session
      (expect assigns :user).to eq user
    end
  end

  describe 'GET #edit' do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :edit , :nick => user.nick , :session => valid_session
      (expect assigns :user).to eq user
    end
  end

  describe 'POST #create' do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create , :params => { :user => valid_attributes } , :session => valid_session
        }.to (change User , :count).by 1
      end


      it "assigns a newly created user as @user" do
        post :create , :params => { :user => valid_attributes } , :session => valid_session
        (expect assigns :user).to be_a User
        (expect assigns :user).to be_persisted
      end

      it "redirects to the created user" do
        post :create , :params => { :user => valid_attributes } , :session => valid_session
        (expect response).to redirect_to User.last
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create , :params => { :user => invalid_attributes } , :session => valid_session
        (expect assigns :user).to be_a_new User
      end

      it "re-renders the 'new' template" do
        post :create , :params => { :user => invalid_attributes } , :session => valid_session
        (expect response).to render_template :new
      end
    end

    context "with duplicated nick" do
      before :each do
        @user = User.create! valid_attributes
      end

      it "assigns a newly created but unsaved user as @user" do
        post :create , :params => { :user => valid_attributes } , :session => valid_session
        (expect assigns :user).to be_a_new User
      end

      it "does not create user" do
        expect {
          post :create , :params => { :user => valid_attributes } , :session => valid_session
        }.to (change User , :count).by 0
      end

      it "re-renders the 'new' template" do
        post :create , :params => { :user => valid_attributes } , :session => valid_session
        (expect response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @user = User.create! valid_attributes
    end

    context "with valid params" do
      let(:new_attributes) { { :nick => 'a-nick' , :bio => 'Another bio.' } }

      it "assigns the requested user as @user" do
        put :update , :nick => @user.nick , :params => { :user => new_attributes } , :session => valid_session
        (expect assigns :user).to eq @user
      end

      it "updates the requested user" do
        put :update , :nick => @user.nick , :params => { :user => new_attributes } , :session => valid_session
        @user.reload
        (expect @user.bio).to eq 'Another bio.'
      end

      it "redirects to the user" do
        put :update , :nick => @user.nick , :params => { :user => new_attributes } , :session => valid_session
        (expect response).to redirect_to @user
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        put :update , :nick => @user.nick , :params => { :user => invalid_attributes } , :session => valid_session
        (expect assigns :user).to eq @user
      end

      it "re-renders the 'edit' template" do
        put :update , :nick => @user.nick , :params => { :user => invalid_attributes } , :session => valid_session
        (expect response).to render_template :edit
      end
    end

    context "with modified nick" do
      it "assigns the user as @user" do
        put :update , :nick => @user.nick , :params => { :user => valid_attributes2 } , :session => valid_session
        (expect assigns :user).to eq @user
      end

      it "does not update user" do
        put :update , :nick => @user.nick , :params => { :user => valid_attributes2 } , :session => valid_session
        @user.reload
        (expect @user.nick).not_to eq valid_attributes2[:nick]
      end

      it "re-renders the 'edit' template" do
        put :update , :nick => @user.nick , :params => { :user => valid_attributes2 } , :session => valid_session
        (expect response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = User.create! valid_attributes
    end

    it "destroys the requested user" do
      expect {
        delete :destroy , :nick => @user.nick , :session => valid_session
      }.to (change User , :count).by -1
    end

    it "redirects to the users list" do
      delete :destroy , :nick => @user.nick , :session => valid_session
      (expect response).to redirect_to users_url
    end
  end
end
