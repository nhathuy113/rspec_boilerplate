class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_oauth(auth)
    
    if user
      session[:user_id] = user.id
      redirect_to welcome_path, notice: 'Successfully signed in!'
    else
      redirect_to login_path, alert: 'Authentication failed.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Successfully signed out!'
  end

  def failure
    redirect_to login_path, alert: 'Authentication failed. Please try again.'
  end
end




