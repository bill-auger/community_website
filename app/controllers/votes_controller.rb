class VotesController < ApplicationController
  before_action :authenticate_user , :only => [ :create , :update ]


  def create
    begin
      poll_id        = vote_params[:poll       ][:id] if vote_params[:poll       ].present?
      poll_option_id = vote_params[:poll_option][:id] if vote_params[:poll_option].present?
      poll           = Poll      .find poll_id
      poll_option    = PollOption.find poll_option_id
      vote           = poll.votes.find_by_user_id current_user.id

      begin
        if create_or_update_vote vote , poll , poll_option
          redirect_to poll , :notice => [ "Status" , "Vote was successfully registered" ]
        end
      rescue
        redirect_to poll , :alert => "Unknown error - Try again"
      end
    rescue
      redirect_to polls_path , :alert => "Unknown error"
    end
  end


private

  def vote_params
    params.require(:poll       ).permit :id
    params.require(:poll_option).permit :id
    poll_option_params = (params.require :poll_option).permit :id
    poll_params        = (params.require :poll       ).permit :id

    { :poll_option => poll_option_params , :poll => poll_params }
  end

  def create_or_update_vote vote , poll , poll_option
    (vote.present? && (vote.poll_option = poll_option) && vote.save!                  ) ||
    (current_user.votes.create :poll_id => poll.id , :poll_option_id => poll_option.id)
  end
end
