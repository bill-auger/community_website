require 'rails_helper'

RSpec.describe 'home/home' , :type => :view do
  before :each do
    assign :featured_projects , [ (Project.create! :name => 'Project 1' , :desc => 'Desc 1') ,
                                  (Project.create! :name => 'Project 2' , :desc => 'Desc 2') ,
                                  (Project.create! :name => 'Project 3' , :desc => 'Desc 3') ,
                                  (Project.create! :name => 'Project 4' , :desc => 'Desc 4') ,
                                  (Project.create! :name => 'Project 5' , :desc => 'Desc 5') ]
  end

  it "renders featured projects" do
    render

    (expect response).to render_template :home
    (expect rendered).to match /Featured Projects:/
    (expect rendered).to match /Project 1/
    (expect rendered).to match /Project 2/
    (expect rendered).to match /Project 3/
    (expect rendered).to match /Project 4/
    (expect rendered).to match /Project 5/
  end
end
