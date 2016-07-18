class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token , :only => :create


  def new
    redirect_to '/auth/developer'
  end

  def create
    begin
      a_user = User.find_or_create_with_omniauth auth_hash

      sign_in a_user
      redirect_to root_url , :notice => [ "Status" , "Signed in" ]
    rescue
      sign_out
      redirect_to root_url , :flash => { :error => [ "Authentication error" , "Unknown error" ] }
    end

  end

  def destroy
    sign_out
    redirect_to root_url , :notice => [ "Status" , "Signed out" ]
  end

  def failure
    redirect_to root_url , :error => [ "Authentication error" , params[:message].humanize ]
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

end
