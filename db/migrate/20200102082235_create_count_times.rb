class CreateCountTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :count_times do |t|

      t.integer :count_hour, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
