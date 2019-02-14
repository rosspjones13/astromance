class SessionsController < ApplicationController
  def new
    @login = true
  end

  def create
    @current_user = User.find_by(username: params[:username])

    if @current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id 
      redirect_to @current_user
    else
      flash.notice = "Username and password do not match"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
  
  def home
    if logged_in?
      redirect_to current_user
    else
      redirect_to login_path
    end
  end
end
