require 'rails_helper'

RSpec.describe 'projects/new' , :type => :view do
  before :each do
    assign :project , Project.new()
  end

  it "infers the controller path" do
    (expect controller.request.path_parameters[:controller]).to eq 'projects'
    (expect controller.controller_path).to eq 'projects'
  end

  it "infers the controller action" do
    (expect controller.request.path_parameters[:action]).to eq 'new'
  end

  it "renders new project form" do
    render

    (expect response).to render_template :new

    assert_select 'form[action=?][method=?]' , projects_path , :post do
      assert_select 'input#project_name[name=?]'    , 'project[name]'
      assert_select 'input#project_repo[name=?]'    , 'project[repo]'
      assert_select 'textarea#project_desc[name=?]' , 'project[desc]'
    end
  end
end
