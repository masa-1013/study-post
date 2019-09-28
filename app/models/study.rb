class Study < ApplicationRecord
  validates :title, length: { maximum: 30 }

  belongs_to :user
  
  # date型を勉強日時の文字列に変換
  def convert_date_to_studydate(date)
    date.strftime("%Y-%m-%d")
  end
  
  # time型を勉強時間の文字列に変換
  def convert_time_to_studytime(time)
    time.strftime("%H時間 %M分")
  end
end
