class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception
  helper_method :current_user
  helper_method :signed_in?
  helper_method :admin?
  helper_method :authenticate_user
  helper_method :authorized_for_project?
  helper_method :authorized_for_user?


protected

  def current_user
    @current_user ||= (User.find session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def admin?
#     current_user.is_admin
    false
  end

  def authenticate_user
    redirect_to signin_url , :alert => "You need to sign in for access to this page" unless signed_in?
  end

  def authorized_for_project? a_project
    a_project.user == current_user
  end

  def authorized_for_user? a_user
    a_user == current_user
  end

end
