class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  private

  def current_user
    return @current_user if defined?(@current_user)
    return unless session[:user_id]

    @current_user = User.find_by_id(session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    return if user_signed_in?

    redirect_to login_path, alert: 'Please sign in to access this page.'
  end
end
