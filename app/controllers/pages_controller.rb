class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:welcome]

  def login
    redirect_to welcome_path if user_signed_in?
  end

  def welcome
    # User is already authenticated via before_action
  end

  def legal
    # Public page - no authentication required
  end

  def change_locale
    locale = params[:locale].to_s.strip.to_sym
    session[:locale] = locale if I18n.available_locales.include?(locale)
    redirect_back(fallback_location: root_path)
  end
end
