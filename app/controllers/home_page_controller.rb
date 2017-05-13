class HomePageController < ApplicationController

  def home
    if logged_in?
      @task_item = current_user.task_items.build if logged_in?
	  @feed_items = current_user.feed
	end 
  end
end
