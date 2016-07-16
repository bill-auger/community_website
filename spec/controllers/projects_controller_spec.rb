require 'rails_helper'

RSpec.describe ProjectsController , :type => :controller do

  let(:valid_attributes  ) { { :name => 'A Project' } }
  let(:valid_attributes2 ) { { :name => 'Project2' } }
  let(:valid_attributes3 ) { { :name => 'Project3' , :repo => 'https://example.org/user/repo'  } }
  let(:valid_attributes4 ) { { :name => 'Project4' , :repo => 'https://example.org/user/repo'  } }
  let(:valid_attributes5 ) { { :name => 'Project5' , :repo => 'https://example.org/user/repo5' } }
  let(:valid_attributes6 ) { { :name => 'Project5' , :repo => 'https://example.org/user/repo'  } }
  let(:invalid_attributes) { { :name => nil } }
  let(:valid_session     ) { {} }

  describe 'GET #index' do
    it "assigns all projects as @projects" do
      project = Project.create! valid_attributes
      get :index , :params => {} , :session => valid_session
      (expect assigns :projects).to eq [project]
    end
  end

  describe 'GET #new' do
    it "assigns a new project as @project" do
      get :new , :params => {} , :session => valid_session
      (expect assigns :project).to be_a_new Project
    end
  end

  describe 'GET #show' do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :show , :id => project.id , :session => valid_session
      (expect assigns :project).to eq project
    end
  end

  describe 'GET #edit' do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :edit , :id => project.id , :session => valid_session
      (expect assigns :project).to eq project
    end
  end

  describe 'POST #create' do
    context "with valid params" do
      it "creates a new Project" do
        expect {
          post :create , :params => { :project => valid_attributes } , :session => valid_session
        }.to (change Project , :count).by 1
      end

      it "assigns a newly created project as @project" do
        post :create , :params => { :project => valid_attributes } , :session => valid_session
        (expect assigns :project).to be_a Project
        (expect assigns :project).to be_persisted
      end

      it "redirects to the created project" do
        post :create , :params => { :project => valid_attributes } , :session => valid_session
        (expect response).to redirect_to Project.last
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        post :create , :params => { :project => invalid_attributes } , :session => valid_session
        (expect assigns :project).to be_a_new Project
      end

      it "re-renders the 'new' template" do
        post :create , :params => { :project => invalid_attributes } , :session => valid_session
        (expect response).to render_template :new
      end
    end

    context "with duplicated name" do
      before :each do
        @project = Project.create! valid_attributes
      end

      it "assigns a newly created but unsaved project as @project" do
        post :create , :params => { :project => valid_attributes } , :session => valid_session
        (expect assigns :project).to be_a_new Project
      end

      it "does not create project" do
        expect {
          post :create , :params => { :project => valid_attributes } , :session => valid_session
        }.to (change Project , :count).by 0
      end

      it "re-renders the 'new' template" do
        post :create , :params => { :project => valid_attributes } , :session => valid_session
        (expect response).to render_template :new
      end
    end

    context "with duplicated URL" do
      before :each do
        @project3 = Project.create! valid_attributes3
      end

      it "assigns a newly created but unsaved project as @project" do
        post :create , :params => { :project => valid_attributes4 } , :session => valid_session
        (expect assigns :project).to be_a_new Project
      end

      it "does not create project" do
        expect {
          post :create , :params => { :project => valid_attributes4 } , :session => valid_session
        }.to (change Project , :count).by 0
      end

      it "re-renders the 'new' template" do
        post :create , :params => { :project => valid_attributes4 } , :session => valid_session
        (expect response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context "with valid params" do
      let(:new_attributes) { { :name => 'An Awesome Project' } }

      it "updates the requested project" do
        project = Project.create! valid_attributes
        put :update , :id => project.id , :params => { :project => new_attributes } , :session => valid_session
        project.reload
        (expect project.name).to eq 'An Awesome Project'
      end

      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        put :update , :id => project.id , :params => { :project => valid_attributes } , :session => valid_session
        (expect assigns :project).to eq project
      end

      it "redirects to the project" do
        project = Project.create! valid_attributes
        put :update , :id => project.id , :params => { :project => valid_attributes } , :session => valid_session
        (expect response).to redirect_to project
      end
    end

    context "with invalid params" do
      it "assigns the project as @project" do
        project = Project.create! valid_attributes
        put :update , :id => project.id , :params => { :project => invalid_attributes } , :session => valid_session
        (expect assigns :project).to eq project
      end

      it "re-renders the 'edit' template" do
        project = Project.create! valid_attributes
        put :update , :id => project.id , :params => { :project => invalid_attributes } , :session => valid_session
        (expect response).to render_template :edit
      end
    end

    context "with duplicated name" do
      before :each do
        @project  = Project.create! valid_attributes
        @project2 = Project.create! valid_attributes2
      end

      it "assigns the project as @project" do
        put :update , :id => @project.id , :params => { :project => valid_attributes2 } , :session => valid_session
        (expect assigns :project).to eq @project
      end

      it "does not update project" do
        put :update , :id => @project.id , :params => { :project=> valid_attributes2 } , :session => valid_session
        @project.reload
        (expect @project.name).not_to eq valid_attributes2[:name]
      end

      it "re-renders the 'edit' template" do
        put :update , :id => @project.id , :params => { :project => valid_attributes2 } , :session => valid_session
        (expect response).to render_template :edit
      end
    end

    context "with duplicated URL" do
      before :each do
        @project5 = Project.create! valid_attributes5
        @project4 = Project.create! valid_attributes4
      end

      it "assigns the project as @project" do
        put :update , :id => @project5.id , :params => { :project => valid_attributes6 } , :session => valid_session
        (expect assigns :project).to eq @project5
      end

      it "does not update project" do
        put :update , :id => @project5.id , :params => { :project=> valid_attributes6 } , :session => valid_session
        @project5.reload
        (expect @project5.repo).not_to eq valid_attributes6[:repo]
      end

      it "re-renders the 'edit' template" do
        put :update , :id => @project5.id , :params => { :project => valid_attributes6 } , :session => valid_session
        (expect response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete :destroy , :id => project.id , :session => valid_session
      }.to (change Project , :count).by -1
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete :destroy , :id => project.id , :session => valid_session
      (expect response).to redirect_to projects_url
    end
  end
end
