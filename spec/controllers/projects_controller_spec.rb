require 'rails_helper'


RSpec.describe ProjectsController , :type => :controller do

  let(:valid_attributes  ) { { :name => 'A Project'   , :user_id => 1 } }
  let(:valid_attributes2 ) { { :name => 'Project2'    , :user_id => 1 } }
  let(:valid_attributes3 ) { { :name => 'Project3'    , :user_id => 1 , :repo => 'https://example.org/user/repo'  } }
  let(:valid_attributes4 ) { { :name => 'Project4'    , :user_id => 1 , :repo => 'https://example.org/user/repo'  } }
  let(:valid_attributes5 ) { { :name => 'Project5'    , :user_id => 1 , :repo => 'https://example.org/user/repo5' } }
  let(:valid_attributes6 ) { { :name => 'Project5'    , :user_id => 1 , :repo => 'https://example.org/user/repo'  } }
  let(:new_attributes    ) { { :name => 'New Project' , :user_id => 1 } }
  let(:invalid_attributes) { { :name => nil           , :user_id => 1 } }
  let(:signed_out_session) { {} }
  let(:signed_in_session ) { { :user_id => 1 } }
  before do
    @this_user = User.create! :nick => 'a-name' , :uid => 'a-uid'
  end

  describe 'GET #index' do
    it "assigns all projects as @projects" do
      project = Project.create! valid_attributes
      get :index , :params => {} , :session => signed_out_session
      (expect assigns :projects).to eq [project]
    end
  end

  describe 'GET #new' do
    context "when signed in" do
      before do
        session[:user_id] = 1
      end

      it "assigns a new project as @project" do
        get :new , :params => {} , :session => signed_in_session
        (expect assigns :project).to be_a_new Project
      end
    end

    context "when signed out" do
      it "should not assign a new project as @project" do
        get :new , :params => {} , :session => signed_out_session
        (expect assigns :project).not_to be_a_new Project
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :show , :id => project.id , :session => signed_out_session
      (expect assigns :project).to eq project
    end
  end

  describe 'GET #edit' do
    before do
      @project = Project.create! valid_attributes
    end

    context "when signed in" do
      before do
        session[:user_id] = 1
      end

      it "assigns the requested project as @project" do
        get :edit , :id => @project.id , :session => signed_in_session
        (expect assigns :project).to eq @project
      end
    end

    context "when signed out" do
      before do
        get :edit , :id => @project.id , :session => signed_out_session
      end

      it "assigns the requested project as @project" do
        (expect assigns :project).to eq @project
      end

      it "redirects to the project show page" do
        (expect response).to redirect_to @project
      end
    end
  end

  describe 'POST #create' do
    context "when signed in" do
      before do
        session[:user_id] = 1
      end

      context "with valid params" do
        it "creates a new Project" do
          expect {
            post :create , :params => { :project => valid_attributes } , :session => signed_in_session
          }.to (change Project , :count).by 1
        end

        it "assigns a newly created project as @project" do
          post :create , :params => { :project => valid_attributes } , :session => signed_in_session
          (expect assigns :project).to be_a Project
          (expect assigns :project).to be_persisted
        end

        it "redirects to the created project show page" do
          post :create , :params => { :project => valid_attributes } , :session => signed_in_session
          (expect response).to redirect_to Project.last
        end
      end

      context "with invalid params" do
        before do
          post :create , :params => { :project => invalid_attributes } , :session => signed_in_session
        end

        it "assigns a newly created but unsaved project as @project" do
          (expect assigns :project).to be_a_new Project
        end

        it "re-renders the 'new' template" do
          (expect response).to render_template :new
        end
      end

      context "with duplicated name" do
        before :each do
          @project = Project.create! valid_attributes
        end

        it "assigns a newly created but unsaved project as @project" do
          post :create , :params => { :project => valid_attributes } , :session => signed_in_session
          (expect assigns :project).to be_a_new Project
        end

        it "does not create project" do
          expect {
            post :create , :params => { :project => valid_attributes } , :session => signed_in_session
          }.to (change Project , :count).by 0
        end

        it "re-renders the 'new' template" do
          post :create , :params => { :project => valid_attributes } , :session => signed_in_session
          (expect response).to render_template :new
        end
      end

      context "with duplicated URL" do
        before :each do
          @project3 = Project.create! valid_attributes3
        end

        it "assigns a newly created but unsaved project as @project" do
          post :create , :params => { :project => valid_attributes4 } , :session => signed_in_session
          (expect assigns :project).to be_a_new Project
        end

        it "does not create project" do
          expect {
            post :create , :params => { :project => valid_attributes4 } , :session => signed_in_session
          }.to (change Project , :count).by 0
        end

        it "re-renders the 'new' template" do
          post :create , :params => { :project => valid_attributes4 } , :session => signed_in_session
          (expect response).to render_template :new
        end
      end
    end

    context "when signed out" do
      it "should not create a new Project" do
        expect {
          post :create , :params => { :project => valid_attributes } , :session => signed_out_session
        }.to (change Project , :count).by 0
      end

      it "redirects to the created project" do
        post :create , :params => { :project => valid_attributes } , :session => signed_out_session
        (expect response).to redirect_to signin_url
      end
    end
  end

  describe 'PUT #update' do
    context "when signed in" do
      before do
        session[:user_id] = 1
        @project = Project.create! valid_attributes
        put :update , :id => @project.id , :params => { :project => new_attributes } , :session => signed_in_session
      end

      context "with valid params" do
        it "updates the requested project" do
          @project.reload
          (expect @project.name).to eq new_attributes[:name]
        end

        it "assigns the requested project as @project" do
          (expect assigns :project).to eq @project
        end

        it "redirects to the project show page" do
          (expect response).to redirect_to @project
        end
      end

      context "with invalid params" do
        before do
          @project = Project.create! valid_attributes
          put :update , :id => @project.id , :params => { :project => invalid_attributes } , :session => signed_in_session
        end

        it "assigns the project as @project" do
          (expect assigns :project).to eq @project
        end

        it "re-renders the 'edit' template" do
          (expect response).to render_template :edit
        end
      end

      context "with duplicated name" do
        before :each do
          @project  = Project.create! valid_attributes
          @project2 = Project.create! valid_attributes2
          put :update , :id => @project.id , :params => { :project => valid_attributes2 } , :session => signed_in_session
        end

        it "assigns the project as @project" do
          (expect assigns :project).to eq @project
        end

        it "does not update project" do
          @project.reload
          (expect @project.name).not_to eq valid_attributes2[:name]
        end

        it "re-renders the 'edit' template" do
          (expect response).to render_template :edit
        end
      end

      context "with duplicated URL" do
        before :each do
          @project5 = Project.create! valid_attributes5
          @project4 = Project.create! valid_attributes4
          put :update , :id => @project5.id , :params => { :project => valid_attributes6 } , :session => signed_in_session
        end

        it "assigns the project as @project" do
          (expect assigns :project).to eq @project5
        end

        it "does not update project" do
          @project5.reload
          (expect @project5.repo).not_to eq valid_attributes6[:repo]
        end

        it "re-renders the 'edit' template" do
          (expect response).to render_template :edit
        end
      end
    end

    context "when signed out" do
      before do
        @project = Project.create! valid_attributes
        put :update , :id => @project.id , :params => { :project => new_attributes } , :session => signed_out_session
      end

      it "should not update the requested project" do
        @project.reload
        (expect @project.name).not_to eq new_attributes[:name]
      end

      it "redirects to the project show page" do
        (expect response).to redirect_to @project
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @project = Project.create! valid_attributes
    end

    context "when signed in" do
      before do
        session[:user_id] = 1
      end

      it "destroys the requested project" do
        expect {
          delete :destroy , :id => @project.id , :session => signed_in_session
        }.to (change Project , :count).by -1
      end

      it "redirects to the projects list" do
        delete :destroy , :id => @project.id , :session => signed_in_session
        (expect response).to redirect_to projects_url
      end
    end

    context "when signed out" do
      it "should not destroy the requested project" do
        expect {
          delete :destroy , :id => @project.id , :session => signed_out_session
        }.to (change Project , :count).by 0
      end

      it "redirects to the project show page" do
        put :update , :id => @project.id , :params => { :project => valid_attributes } , :session => signed_out_session
        (expect response).to redirect_to @project
      end
    end
  end
end
