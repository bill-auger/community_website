require 'rails_helper'

RSpec.describe HomeController , :type => :controller do
  let(:valid_session) { {} }

  describe 'GET #index' do
    it "assigns the first five projects as @featured_projects" do
      projects = [ (Project.create! :name => 'Project1' , :desc => 'Desc1') ,
                   (Project.create! :name => 'Project2' , :desc => 'Desc2') ,
                   (Project.create! :name => 'Project3' , :desc => 'Desc3') ,
                   (Project.create! :name => 'Project4' , :desc => 'Desc4') ,
                   (Project.create! :name => 'Project5' , :desc => 'Desc5') ]

      get :home , :params => {} , :session => valid_session
      (expect assigns :featured_projects).to eq projects
    end
  end

end
