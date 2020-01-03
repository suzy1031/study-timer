class RemoveStartTimeFromStartDays < ActiveRecord::Migration[5.2]
  def change
    remove_column :start_days, :start_time, :datetime
  end
end
