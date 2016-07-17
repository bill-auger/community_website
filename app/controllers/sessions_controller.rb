class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token , :only => :create


  def create
    begin
      a_user = User.find_or_create_with_omniauth auth_hash

      sign_in a_user
      redirect "Signed in"
    rescue
      sign_out
      redirect "Error signing in"
    end

  end

  def destroy
    sign_out
    redirect "Signed out"
  end


protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def sign_in a_user
    @current_user     = a_user
    session[:user_id] = @current_user.id
  end

  def sign_out
    @current_user     = nil
    session[:user_id] = nil
  end

  def redirect notice
    redirect_to root_url , :notice => notice
  end

end
