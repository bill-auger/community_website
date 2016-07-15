require 'rails_helper'

RSpec.describe 'users/new' , :type => :view do
  before :each do
    assign :user , User.new()
  end

  it "infers the controller path" do
    (expect controller.request.path_parameters[:controller]).to eq 'users'
    (expect controller.controller_path).to eq 'users'
  end

  it "infers the controller action" do
    (expect controller.request.path_parameters[:action]).to eq 'new'
  end

  it "renders new user form" do
    render

    (expect response).to render_template :new

    assert_select 'form[action=?][method=?]' , users_path , :post do
      assert_select 'input#user_nick[name=?][readonly]' , 'user[nick]'
    end
  end
end
