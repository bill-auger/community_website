require 'rails_helper'

RSpec.describe 'users/edit' , :type => :view do
  before :each do
    @user = assign :user , (User.create! :nick => 'a-nick')
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
    (expect rendered).to match /a-nick/

    assert_select 'form[action=?][method=?]' , user_path(@user) , :post do
      assert_select 'input#user_nick[name=?][readonly]' , 'user[nick]'
    end
  end
end
