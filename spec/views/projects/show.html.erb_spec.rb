require 'rails_helper'

RSpec.describe 'projects/show' , :type => :view do
  before :each do
    @project = assign :project , (Project.create! :name => 'A Project'                     ,
                                                  :repo => 'https://example.org/user/repo' ,
                                                  :desc => 'A description'                 )
    # stubs of application_controller.rb
    def view.authorized_for_project? a_project ; a_project.user == @current_user ; end ;
  end

  it "infers the controller path" do
    (expect controller.request.path_parameters[:controller]).to eq 'projects'
    (expect controller.controller_path).to eq 'projects'
  end

  it "infers the controller action" do
    (expect controller.request.path_parameters[:action]).to eq 'show'
  end

  it "renders attributes" do
    render

    (expect response).to render_template :show
    (expect rendered).to match /A Project/
    (expect rendered).to match /https:\/\/example.org\/user\/repo/
    (expect rendered).to match /A description/
  end

end

