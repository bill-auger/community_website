require 'rails_helper'


RSpec.describe HomeController , :type => :controller do
  let(:valid_session) { {} }
  before do
    @this_user = User.create! :nick => 'a-name' , :uid => 'a-uid'
  end

  describe 'GET #home' do
    it "assigns the first five projects as @featured_projects" do
      projects = [ (Project.create! :name => 'Project 1' , :desc => 'Desc 1' , :user_id => 1) ,
                   (Project.create! :name => 'Project 2' , :desc => 'Desc 2' , :user_id => 1) ,
                   (Project.create! :name => 'Project 3' , :desc => 'Desc 3' , :user_id => 1) ,
                   (Project.create! :name => 'Project 4' , :desc => 'Desc 4' , :user_id => 1) ,
                   (Project.create! :name => 'Project 5' , :desc => 'Desc 5' , :user_id => 1) ]

      get :home , :params => {} , :session => valid_session
      (expect assigns :featured_projects).to eq projects
    end
  end

end
