class Wifi < ApplicationRecord
  # http://guides.rubyonrails.org/association_basics.html
  has_many :active_connections, class_name:  "Connection",
                                foreign_key: "user_id",
								dependent:   :destroy
  has_many :users, through: :active_connections
  #belongs_to :user 
  validates :key, presence: true
  
end
