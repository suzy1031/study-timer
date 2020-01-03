class CreateStartDays < ActiveRecord::Migration[5.2]
  def change
    create_table :start_days do |t|

      t.date :start_day, null: false
      t.datetime :start_time, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
