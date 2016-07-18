require 'rails_helper'

RSpec.describe 'users/edit' , :type => :view do
  before :each do
    @user = assign :user , (User.create! :nick => 'a-nick' , :uid => 'a-uid')

    # stubs of application_controller.rb
    def view.admin?
#     @current_user.is_admin
      false
    end
  end

  it "infers the controller path" do
    (expect controller.request.path_parameters[:controller]).to eq 'users'
    (expect controller.controller_path).to eq 'users'
  end

  it "infers the controller action" do
    (expect controller.request.path_parameters[:action]).to eq 'edit'
  end

  it "renders the edit user form" do
    render

    (expect response).to render_template :edit
    (expect rendered).to     match /a-nick/
    (expect rendered).not_to match /<input id="user_uid" name="user[uid]" type="text" value="a-uid" \/>/

    assert_select 'form[action=?][method=?]' , user_path(@user) , :post do
      assert_select 'input#user_bio[name=?]' , 'user[bio]'
    end
  end
end
