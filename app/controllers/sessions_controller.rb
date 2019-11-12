class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      remember user
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
