class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    store_location
    redirect_to login_path
  end
end
