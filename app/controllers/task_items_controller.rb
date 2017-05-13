class TaskItemsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :admin_user,     only: :destroy
  

  def create
    @user = User.find(params[:user_id])
    @task_item = @user.task_items.build(task_item_params)
    if @task_item.save
      flash[:success] = "Task Added!"
      redirect_to @user
    else
	  @feed_items = []
      redirect_to @user
	end
  end

  def destroy
    @task_item.destroy
    flash[:success] = "Task deleted"
    redirect_to request.referrer || root_url
  end
  
  private

    def task_item_params
      params.require(:task_item).permit(:description, :points, :approval_required)
    end
	
	def correct_user
      @task_item = current_user.task_items.find_by(id: params[:id])
      redirect_to root_url if @task_item.nil?
    end
	
	# Confirms an admin user.
    def admin_user
	  @user = User.find(params[:id])
      @task_item = @user.task_items.find_by(id: params[:id])
	  #@task_item = current_user.task_items.find_by(id: params[:id])
      redirect_to(root_url) unless current_user.admin?
    end
end