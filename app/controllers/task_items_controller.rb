class TaskItemsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @task_item = current_user.task_items.build(task_item_params)
    if @task_item.save
      flash[:success] = "Task Added!"
      redirect_to root_url
    else
	  @feed_items = []
      render 'home_page/home'
	end
  end

  def destroy
    @task_item.destroy
    flash[:success] = "Task deleted"
    redirect_to request.referrer || root_url
  end
  
  private

    def task_item_params
      params.require(:task_item).permit(:description, :points)
    end
	
	def correct_user
      @task_item = current_user.task_items.find_by(id: params[:id])
      redirect_to root_url if @task_item.nil?
    end
end