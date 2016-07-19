require 'rails_helper'


RSpec.describe 'projects/index' , :type => :view do
  before :each do
    @this_user = User.create! :nick => 'a-name' , :uid => 'a-uid'
    assign :projects , [ (Project.create! :name => 'A Project'       , :desc => 'A Description'       , :user_id => 1) ,
                         (Project.create! :name => 'Another Project' , :desc => 'Another Description' , :user_id => 1) ]
  end

  it "renders a list of projects" do
    render

    (expect response).to render_template :index
    (expect rendered).to match /A Project/
    (expect rendered).to match /A Description/
    (expect rendered).to match /Another Project/
    (expect rendered).to match /Another Description/
  end
end
