require 'rails_helper'

RSpec.describe HomeController , :type => :controller do
  let(:valid_session) { {} }

  describe 'GET #index' do
    it "assigns the first five projects as @featured_projects" do
      projects = [ (Project.create! :name => 'Project 1' , :desc => 'Desc 1') ,
                   (Project.create! :name => 'Project 2' , :desc => 'Desc 2') ,
                   (Project.create! :name => 'Project 3' , :desc => 'Desc 3') ,
                   (Project.create! :name => 'Project 4' , :desc => 'Desc 4') ,
                   (Project.create! :name => 'Project 5' , :desc => 'Desc 5') ]

      get :home , :params => {} , :session => valid_session
      (expect assigns :featured_projects).to eq projects
    end
  end

end
