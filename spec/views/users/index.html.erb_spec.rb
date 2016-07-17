require 'rails_helper'

RSpec.describe 'users/index' , :type => :view do
  before :each do
    assign :users , [ (User.create! :nick => 'a-nick'      , :uid => 'a-uid'      ) ,
                      (User.create! :nick => 'another-nick', :uid => 'another-uid') ]
  end

  it "renders a list of users" do
    render

    (expect response).to render_template :index
    (expect rendered).to match /a-nick/
    (expect rendered).to match /another-nick/
  end
end
