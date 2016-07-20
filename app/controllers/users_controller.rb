class UsersController < ApplicationController
  before_action :set_user           , only: [ :show , :edit , :update , :destroy ]
  before_action :authorize_for_user , only: [         :edit , :update , :destroy ]


  def index ; @users = User.all ; end ;

  def show ; end ;

  def edit ; end ;

  def update
    is_valid_update = params[:user][:nick] == @user.nick &&
                      params[:user][:uid ] == @user.uid

    if is_valid_update && (@user.update user_params)
      redirect_to @user , :notice => [ "Status" , "User was successfully updated" ]
    else
      render action: 'edit' , :alert => "Uknown error - Try again"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end


private

  def set_user
    is_friendly_url = params[:nick].to_i == 0
    @user           = is_friendly_url ? (User.find_by_nick params[:nick]) :
                                        (User.find         params[:nick])
    params[:nick]   = @user.nick if @user.present?

    redirect_to users_path unless @user.present?
  end

  def authorize_for_user
    redirect_to @user , :alert => "Access denied" unless authorized_for_user? @user
  end

  def user_params
    required_params  = params.require :user
    permitted_params = required_params.permit :nick , :uid , :bio , :avatar , :is_admin
    permitted_params.require :nick
    permitted_params.require :uid
    permitted_params
  end
end
