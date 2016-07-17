class HomeController < ApplicationController
  before_action :verify_current_user


  def home
    @featured_projects = Project.all[0..4]
  end

end
