class Connection < ApplicationRecord
  # http://guides.rubyonrails.org/association_basics.html:
  belongs_to :user, class_name: "User"
  belongs_to :wifi, class_name: "Wifi"
  
end
