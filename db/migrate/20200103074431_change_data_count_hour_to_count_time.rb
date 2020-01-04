class ChangeDataCountHourToCountTime < ActiveRecord::Migration[5.2]
  def change
    change_column :count_times, :count_hour, :float
  end
end