class ProjectsController < ApplicationController
  before_action :set_project           , :only => [ :edit , :update , :destroy , :show ]
  before_action :authorize_for_project , :only => [ :edit , :update , :destroy ]
  before_action :authenticate_user     , :only => [ :new , :create ]


  def index ; @projects = Project.all ; end ;

  def show ; end ;

  def new ; @project = Project.new ; end ;

  def edit ; end ;

  def create
    @project = current_user.projects.create project_params

    if @project.save
      redirect_to @project , :notice => [ "Status" , "Project was successfully created" ]
    else
      render action: 'new' , :alert => "Unknown error - Try again"
    end
  end

  def update
    if @project.update project_params
      redirect_to @project , notice: [ "Status" , "Project was successfully updated" ]
    else
      render action: 'edit' , :alert => "Unknown error - Try again"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url
  end


private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_for_project
    redirect_to @project , :alert => "Access denied" unless authorized_for_project? @project
  end

  def project_params
    ((params[:params] || params).require :project).permit :name , :repo , :desc , :user_id
  end
end
