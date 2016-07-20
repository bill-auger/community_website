module SessionsHelper

  def current_user
    user_id           = session[:user_id]
    current_user_id   = @current_user.nil? ? nil : @current_user.id
    @current_user     = user_id.nil?               ? nil           :
                        current_user_id == user_id ? @current_user : (User.find_by_id user_id)
    session[:user_id] = nil if @current_user.nil?

    @current_user
  end

  def signed_in?
    current_user.present?
  end

  def admin?
    signed_in? && current_user.is_admin
  end

  def authenticate_user
    redirect_to signin_url , :alert => UNAUTHORIZED_MSG unless signed_in?
  end

  def authorized_for_project? a_project
    signed_in? && a_project.user == current_user
  end

  def authorized_for_user? a_user
    signed_in? && a_user == current_user
  end

  def authorized_for_poll? a_poll
    signed_in? && a_poll.user == current_user
  end

end
