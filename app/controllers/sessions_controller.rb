class SessionsController < ApplicationController
  #Note: Sessions has no model. Refer to sessions_helper
  
  def new
  end
  
  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
	  log_in user
	  params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
	  # flash.now - Only display error message on the rendered page.
      flash.now[:danger] = 'Invalid username/password combination' 
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
