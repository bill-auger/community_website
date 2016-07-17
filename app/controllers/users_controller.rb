class UsersController < ApplicationController
  before_action :verify_current_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index ; @users = User.all ; end ;

  def show ; end ;

  def new ; @user = User.new ; end ;

  def edit ; end ;

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user , :notice => 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if user_params[:nick] == @user.nick && @user.update(user_params)
      redirect_to @user , :notice => 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end


private

  def set_user
    @user = params[:nick].to_i > 0 ? (User.find         params[:nick]) :
                                     (User.find_by_nick params[:nick])

    redirect_to new_user_path unless @user.present?
  end

  def user_params
    (params[:params] || params).require(:user).permit(:nick , :bio)
  end
end
