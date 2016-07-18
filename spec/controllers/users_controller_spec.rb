require 'rails_helper'


RSpec.describe UsersController , :type => :controller do
  let(:valid_attributes  ) { { :nick => 'a-nick'    , :uid => 'a-uid'    , :bio => 'A bio.'     } }
  let(:new_attributes    ) { { :nick => 'test-name' , :uid => 'test-uid' , :bio => 'A new bio.' } }
  let(:invalid_attributes) { { :nick => nil         , :uid => 'test-uid' , :bio => 'A new bio.' } }
  let(:signed_out_session) { {} }
  let(:signed_in_session ) { { :user_id => 2 } }
  before do
    @other_user = User.create! :nick => 'other-name' , :uid => 'other-uid'
    @this_user  = User.create! :nick => 'test-name'  , :uid => 'test-uid'
  end

  describe 'GET #index' do
    before do
      get :index , :params => {} , :session => signed_out_session
    end

    it "assigns all users as @users" do
      (expect assigns :users).to eq [ @other_user , @this_user ]
    end

    it "renders the 'index' template" do
      (expect response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show , :nick => @other_user.nick , :session => signed_out_session
    end

    it "assigns the requested user as @user" do
      (expect assigns :user).to eq @other_user
    end

    it "renders the 'show' template" do
      (expect response).to render_template :show
    end
  end

  describe 'GET #edit' do
    context "when signed in" do
      before do
        session[:user_id] = 2
      end

      context "accessing the current user" do
        before do
          get :edit , :nick => @this_user.nick , :session => signed_in_session
        end

        it "assigns the requested user as @user and @current_user" do
          (expect assigns :user        ).to eq @this_user
          (expect assigns :current_user).to eq @this_user
        end

        it "renders the 'edit' template" do
          (expect response).to render_template :edit
        end
      end

      context "accessing another user" do
        before do
          get :edit , :nick => @other_user.nick , :session => signed_in_session
        end

        it "assigns the requested user as @user" do
          (expect assigns :user).to eq @other_user
        end

        it "should not assign the requested user as @current_user" do
          (expect assigns :current_user).to     eq @this_user
          (expect assigns :current_user).not_to eq @other_user
        end
      end
    end

    context "when signed out" do
      before do
        get :edit , :nick => @other_user.nick , :session => signed_out_session
      end

      it "should assign the requested user as @user" do
        (expect assigns :user).to eq @other_user
      end

      it "redirects to the user show page" do
        (expect response     ).to redirect_to @other_user
        (expect flash[:alert]).to eq "Access denied"
      end
    end
  end

  describe 'PUT #update' do
    context "when signed in" do
      before do
        session[:user_id] = 2
      end

      context "with valid params" do
        before do
          put :update , :nick => @this_user.nick , :user => new_attributes , :session => signed_in_session
        end

        it "assigns the current user as @user" do
          (expect assigns :user        ).to eq @this_user
          (expect assigns :current_user).to eq @this_user
        end

        it "updates the current user" do
          @this_user.reload
          (expect @this_user.bio).to eq new_attributes[:bio]
        end

        it "redirects to the user show page" do
          (expect response).to redirect_to @this_user
        end
      end

      context "with invalid params" do
        before do
          put :update , :nick => @this_user.nick , :user => invalid_attributes , :session => signed_in_session
        end

        it "assigns the user as @user" do
          (expect assigns :user).to eq @this_user
        end

        it "should not update the requested user" do
          @this_user.reload
          (expect @this_user.bio).not_to eq invalid_attributes[:bio]
        end

        it "re-renders the 'edit' template" do
          (expect response).to render_template :edit
        end
      end

      context "with modified nick" do
        before do
          put :update , :nick => @this_user.nick , :user => valid_attributes , :session => signed_in_session
        end

        it "assigns the user as @user" do
          (expect assigns :user).to eq @this_user
        end

        it "should not update user" do
          @this_user.reload
          (expect @this_user.nick).not_to eq valid_attributes[:nick]
          (expect @this_user.bio ).not_to eq valid_attributes[:bio ]
        end

        it "re-renders the 'edit' template" do
          (expect response).to render_template :edit
        end
      end
    end

    context "when signed out" do
      before do
        put :update , :nick => @other_user.nick , :user => valid_attributes , :session => signed_out_session
      end

      it "should assign the user as @user" do
        (expect assigns :user).to eq @other_user
      end

      it "should not update user" do
        @other_user.reload
        (expect @other_user.nick).not_to eq valid_attributes[:nick]
      end

      it "redirects to the user show page" do
        (expect response).to redirect_to @other_user
        (expect flash[:alert]).to eq "Access denied"
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when signed in" do
      before do
        session[:user_id] = 2
      end

      it "destroys the requested user" do
        expect {
          delete :destroy , :nick => @this_user.nick , :session => signed_in_session
        }.to (change User , :count).by -1
      end

      it "redirects to the users list" do
        delete :destroy , :nick => @this_user.nick , :session => signed_in_session
        (expect response).to redirect_to users_url
      end
    end

    context "when signed out" do
      it "should not destroy the requested user" do
        expect {
          delete :destroy , :nick => @other_user.nick , :session => signed_out_session
        }.to (change User , :count).by 0
      end

      it "redirects to the users show page" do
        delete :destroy , :nick => @other_user.nick , :session => signed_out_session
        (expect response).to redirect_to @other_user
        (expect flash[:alert]).to eq "Access denied"
      end
    end
  end
end
