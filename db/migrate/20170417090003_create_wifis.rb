class CreateWifis < ActiveRecord::Migration[5.0]
  def change
    create_table :wifis do |t|
      t.string :key
      t.string :name
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
