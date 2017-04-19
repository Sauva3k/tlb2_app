class Connection < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :wifi, class_name: "Wifi"
end
