require 'rails_helper'


RSpec.describe 'projects/edit' , :type => :view do
  before :each do
    @this_user = User.create! :nick => 'a-name' , :uid => 'a-uid'
    @project   = assign :project , (Project.create! :name    => 'A Project'                     ,
                                                    :repo    => 'https://example.org/user/repo' ,
                                                    :desc    => 'A description'                 ,
                                                    :user_id => 1                               )
  end

  it "infers the controller path" do
    (expect controller.request.path_parameters[:controller]).to eq 'projects'
    (expect controller.controller_path).to eq 'projects'
  end

  it "infers the controller action" do
    (expect controller.request.path_parameters[:action]).to eq 'edit'
  end

  it "renders the edit project form" do
    render

    (expect response).to render_template :edit
    (expect rendered).to match /A Project/
    (expect rendered).to match /https:\/\/example.org\/user\/repo/
    (expect rendered).to match /A description/

    assert_select 'form' , :action => project_path(@project) , :method => :post do
      assert_select 'input#project_name[name=?]'    , 'project[name]'
      assert_select 'input#project_repo[name=?]'    , 'project[repo]'
      assert_select 'textarea#project_desc[name=?]' , 'project[desc]'
    end
  end
end
