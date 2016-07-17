require "rails_helper"


RSpec.describe SessionsController , :type => :routing do
  describe "routing" do
    it "routes /auth/:provider/callback to #create" do
      (expect :post => '/auth/developer/callback').to route_to 'sessions#create' , :provider => "developer"
    end

    it "routes /auth/failure to #fail" do
      (expect :get => '/auth/failure'            ).to route_to 'sessions#fail'
    end

    it "routes /signout to #destroy" do
      (expect :get => '/signout'                 ).to route_to 'sessions#destroy'
    end
  end
end
