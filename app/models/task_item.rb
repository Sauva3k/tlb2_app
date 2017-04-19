class TaskItem < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :points, presence: true
end
