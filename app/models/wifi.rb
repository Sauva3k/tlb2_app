class Wifi < ApplicationRecord
  has_many :active_connections, class_name:  "Connection",
                                foreign_key: "wifi_id",
								dependent:   :destroy
  has_many :users, through: :active_relationships
  
  # Add a user.
  def add(user)
    added << user
  end

  # Unfollows a user.
  def remove(user)
    added.delete(user)
  end

  # Returns true if the current user is following the other user.
  def added(user)
    added.include?(user)
  end
end
