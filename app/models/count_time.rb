class CountTime < ApplicationRecord
  belongs_to :user
  # 5件のレコードを取得する
  def self.get_user_time_desc_5
    self.order("created_at DESC").limit(5)
  end
  # 昨日のレコードを取得する
  def self.get_yesterday_hour
    self.where("DATE(created_at) = ?", Date.today-1)
  end
  # 先週1週間のレコードを取得し、合計時間を計算する
  def self.get_last_monday_to_sunday
    self.where(created_at: (Date.today - 1.week).beginning_of_week..(Date.today - 1.week).end_of_week.end_of_day).sum(:count_hour)
  end
  # 今週1週間のレコードを取得し、合計時間をパーセントに計算する
  def self.get_percent_this_week
    self.where(created_at: Date.today.beginning_of_week..Date.today.end_of_week.end_of_day).sum(:count_hour)
  end
end
