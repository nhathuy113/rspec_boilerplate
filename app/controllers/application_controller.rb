class ApplicationController < ActionController::Base
  before_action :set_locale
  helper_method :current_user, :user_signed_in?

  private

  def current_user
    return @current_user if defined?(@current_user)
    return unless session[:user_id]

    @current_user = User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    return if user_signed_in?

    redirect_to login_path, alert: t('errors.sign_in_required')
  end

  def set_locale
    return I18n.locale = session[:locale] if session[:locale]
    return I18n.locale = extract_browser_locale if extract_browser_locale

    I18n.locale = I18n.default_locale
  end

  def extract_browser_locale
    # Typical Accept-Language header: "vi-VN,vi;q=0.9,en;q=0.8,ja;q=0.7"
    # Format: language-region,language;q=quality,language;q=quality
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    return unless accept_language

    # Extract first 2-letter language code (e.g., "vi" from "vi-VN,vi;q=0.9,en;q=0.8")
    browser_language = accept_language.scan(/^[a-z]{2}/).first
    return unless browser_language

    # Return language only if it's in our supported locales (en, vi, ja)
    browser_language if I18n.available_locales.include?(browser_language.to_sym)
  end
end
