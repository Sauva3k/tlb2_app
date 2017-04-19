class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.integer :wifi_id
      t.integer :user_id

      t.timestamps
    end
	add_index :connections, :wifi_id
    add_index :connections, :user_id
    add_index :connections, [:wifi_id, :user_id], unique: true
  end
end
