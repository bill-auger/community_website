class HomeController < ApplicationController

  def home
    @featured_projects = Project.all[0..4]
  end

end
