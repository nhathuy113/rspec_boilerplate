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
end


