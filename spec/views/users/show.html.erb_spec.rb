require 'rails_helper'

RSpec.describe 'users/show' , :type => :view do
  before :each do
    @user = assign :user , (User.create! :nick => 'a-nick' , :uid => 'a-uid')

    # stubs of application_controller.rb
    def view.authorized_for_user? a_user ; a_user == @current_user ; end ;
  end

  it "infers the controller path" do
    (expect controller.request.path_parameters[:controller]).to eq 'users'
    (expect controller.controller_path).to eq 'users'
  end

  it "infers the controller action" do
    (expect controller.request.path_parameters[:action]).to eq 'show'
  end

  it "renders attributes" do
    render

    (expect response).to render_template :show
    (expect rendered).to match /a-nick/
  end

end

