module SessionsHelper

  def current_user
    user_id       = session[:user_id]
    @current_user = user_id.nil? ? @current_user : (User.find user_id)
  end

  def signed_in?
    current_user.present?
  end

  def admin?
    current_user.is_admin
  end

  def authenticate_user
    redirect_to signin_url , :alert => "You need to sign in for access to this page" unless signed_in?
  end

  def authorized_for_project? a_project
    signed_in? && a_project.user == current_user
  end

  def authorized_for_user? a_user
    signed_in? && a_user == current_user
  end

end
