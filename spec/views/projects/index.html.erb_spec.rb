require 'rails_helper'

RSpec.describe 'projects/index' , :type => :view do
  before :each do
    assign :projects , [ (Project.create! :name => 'A Project'       , :desc => 'A Description'      ) ,
                         (Project.create! :name => 'Another Project' , :desc => 'Another Description') ]
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
