class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
	@task_item = @user.task_items.build 
	@feed_items = @user.feed
  end

  def new
    @user = User.new 
  end
  
  def create
    # Create new user
    @user = User.new(user_params)
	# Save user to Users table and create entry in Connections table
    if @user.save && @user.wifis << Wifi.find(1)
	  # Allow newly created users to login immediately after sign-up
	  log_in @user
	  # Flash: Temporary message to new user
	  flash[:success] = "Welcome to Tech-Life Balance!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    #Note: need to handle non-admin user updating profile to 'Admin' - should only be done by Admin
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
	  flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end
	
	# Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
	
	def wifi_params
      params.require(:wifi).permit(:key)
    end	
end
