require "rails_helper"

RSpec.describe UsersController , :type => :routing do
  describe "routing" do

    it "routes to #index" do
      (expect :get    => '/users'            ).to route_to 'users#index'
    end

    it "routes to #new" do
      (expect :get    => '/users/new'        ).to route_to 'users#new'
    end

    it "routes to #show" do
      (expect :get    => '/users/1'          ).to route_to 'users#show'    , :nick => '1'
    end

    it "routes to #show by nick" do
      (expect :get    => '/users/a-user'     ).to route_to 'users#show'    , :nick => 'a-user'
    end

    it "routes to #edit" do
      (expect :get    => '/users/1/edit'     ).to route_to 'users#edit'    , :nick => '1'
    end

    it "routes to #edit by nick" do
      (expect :get    => '/users/a-user/edit').to route_to 'users#edit'    , :nick => 'a-user'
    end

    it "routes to #create" do
      (expect :post   => '/users'            ).to route_to 'users#create'
    end

    it "routes to #update via PUT" do
      (expect :put    => '/users/1'          ).to route_to 'users#update'  , :nick => '1'
    end

    it "routes to #update via PATCH" do
      (expect :patch  => '/users/1'          ).to route_to 'users#update'  , :nick => '1'
    end

    it "routes to #update by nick via PUT" do
      (expect :put    => '/users/a-user'     ).to route_to 'users#update'  , :nick => 'a-user'
    end

    it "routes to #update by nick via PATCH" do
      (expect :patch  => '/users/a-user'     ).to route_to 'users#update'  , :nick => 'a-user'
    end

    it "routes to #destroy" do
      (expect :delete => '/users/1'          ).to route_to 'users#destroy' , :nick => '1'
    end

    it "routes to #destroy by nick" do
      (expect :delete => '/users/a-user'     ).to route_to 'users#destroy' , :nick => 'a-user'
    end
  end
end
