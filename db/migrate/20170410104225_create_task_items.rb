class CreateTaskItems < ActiveRecord::Migration[5.0]
  def change
    create_table :task_items do |t|
      t.text :description
      t.integer :points
      t.references :user, foreign_key: true

      t.timestamps
    end
	add_index :task_items, [:user_id, :created_at]
  end
end
