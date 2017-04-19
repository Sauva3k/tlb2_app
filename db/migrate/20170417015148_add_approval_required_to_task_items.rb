class AddApprovalRequiredToTaskItems < ActiveRecord::Migration[5.0]
  def change
    add_column :task_items, :approval_required, :boolean, default: false
  end
end
