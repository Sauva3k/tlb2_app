class ConnectionsController < ApplicationController

#Connections connects User to Wifi 

  def new
    @connection = Connection.new 
	@user = User.new
  end
  
  #User in Sign-up form to ensure Wifi key enterred in form matches key in database.
  def confirm_key

	wifi = Wifi.find_by(key: params[:wifi][:key])
	
	if wifi && !wifi.status
	  #Change Wifi Status to TRUE
	  flash[:success] = "Wifi Activated"
	  redirect_to signup_path(key: params[:wifi][:key])
	else
	  flash[:error] = "Wifi Key is not valid"
	  redirect_to '/connection'
	end 
  end 
  
end
