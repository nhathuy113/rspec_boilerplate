class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_oauth(auth)

    if user
      session[:user_id] = user.id
      redirect_to welcome_path, notice: t('sessions.sign_in_success')
    else
      redirect_to login_path, alert: t('sessions.auth_failed')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: t('sessions.sign_out_success')
  end

  def failure
    redirect_to login_path, alert: t('sessions.auth_failed_retry')
  end
end
