class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index ; @users = User.all ; end ;

  def show ; end ;

  def new ; @user = User.new ; end ;

  def edit ; end ;

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user , notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if user_params[:nick] == @user.nick && @user.update(user_params)
        format.html { redirect_to @user , notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
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
