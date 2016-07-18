require 'rails_helper'


RSpec.describe 'layouts/application' , :type => :view do
  before :each do
    def view.signed_in?
      false
    end

    render
  end


  it "renders the top navbar" do
    (expect rendered).to match /<div id="top-nav-div">/
  end

  it "renders the content div" do
    (expect rendered).to match /<div id="content-div">/
  end
end
