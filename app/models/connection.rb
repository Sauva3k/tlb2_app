class Connection < ApplicationRecord
  # http://guides.rubyonrails.org/association_basics.html:
  belongs_to :user, class_name: "User"
  belongs_to :wifi, class_name: "Wifi"
  
  #see http://theartandscienceofruby.com/2015/08/20/multiple-models-in-a-single-form/  
  #accepts_nested_attributes_for :wifis
  #accepts_nested_attributes_for :users
end
