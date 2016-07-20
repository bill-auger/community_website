class PollsController < ApplicationController
  before_action :set_poll           , :only => [ :show , :edit , :update , :destroy ]
  before_action :authenticate_user  , :only => [ :new  , :create ]
  before_action :set_option         , :only => [ :show ]
  before_action :set_projects       , :only => [ :new  , :edit , :create , :update ]
  before_action :authorize_for_poll , :only => [ :edit , :update , :destroy ]


  def index ; @polls = Poll.all ; end ;

  def show ; end ;

  def new ; @poll = Poll.new ; end ;

  def edit ; end ;

  def create
    @poll = current_user.polls.create poll_params

    if @poll.save
      redirect_to edit_poll_path @poll , :notice => [ "Status" , "Poll was successfully created" ]
    else
      render action: 'new' , :alert => "Unknown error - Try again"
    end
  end

  def update
    if @poll.update poll_params
      redirect_to @poll , notice: 'Poll was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @poll.destroy
    redirect_to polls_url , notice: 'Poll was successfully destroyed.'
  end


private

  def set_poll
    @poll = Poll.includes(:poll_options).find_by_id params[:id]
  end

  def set_option
    @selected_option = current_user.poll_options.find_by_poll_id @poll.id if signed_in?
  end

  def set_projects
    @projects = current_user.projects.all.order :name
  end

  def authorize_for_poll
    redirect_to @poll , :alert => "Access denied" unless authorized_for_poll? @poll
  end

  def poll_params
    params.require(:poll).permit :topic , :is_open , :project_id ,
                                 :poll_options_attributes => [ :id , :option , :is_other , :poll_id , :_destroy ]
  end
end
