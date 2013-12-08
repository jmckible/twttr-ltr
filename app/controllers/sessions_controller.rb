class SessionsController < ApplicationController

  def new
    redirect_to root_url if logged_in?
  end

  def create
    user = User.authenticate request.env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end