class SessionsController < ApplicationController
  def new
    # Render login form
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in user
      if user.admin?
        redirect_to admin_dashboard_path, notice: 'Logged in successfully!'
      else
        redirect_to root_path, notice: 'Logged in successfully!'
      end
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end
