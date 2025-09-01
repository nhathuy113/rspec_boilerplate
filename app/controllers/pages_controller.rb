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
    locale = params[:locale].to_s.strip
    if I18n.available_locales.include?(locale.to_sym)
      session[:locale] = locale
    else
      session[:locale] = 'en'
    end
    redirect_back(fallback_location: login_path)
  end

  ## DEBUG
  # def change_locale
  #   Rails.logger.debug "[DEBUG] change_locale called with params: #{params.inspect}"
  #   print "[DEBUG] change_locale called with params: #{params.inspect}"
  #   puts "[DEBUG] change_locale called with params: #{params.inspect}" # shows in test output

  #   session[:locale] = params[:locale].to_s.strip.presence || 'en'
  #   Rails.logger.debug "[DEBUG] session[:locale] set to: #{session[:locale]}"
  #   puts "[DEBUG] session[:locale] set to: #{session[:locale]}"

  #   redirect_to(request.referer.presence || login_path)
  # end
end
