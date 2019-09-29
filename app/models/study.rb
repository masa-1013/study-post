class Study < ApplicationRecord
  validates :title, length: { maximum: 30 }

  belongs_to :user
  
  #タイムラインに表示する勉強記録の取得
  def self.select_public_studies
    Study.joins("inner join users on studies.user_id = 
      users.id and users.public = true").select("studies.*, users.name").order(updated_at: :desc)
  end

  #date型を勉強日時の文字列に変換
  def convert_date_to_studydate(date)
    date.strftime("%Y/%m/%d")
  end
  
  #time型を勉強時間の文字列に変換
  def convert_time_to_studytime(time)
    time.strftime("%H時間 %M分")
  end

  #date型を投稿日時の文字列に変換
  def convert_date_to_posttime(time)
    time.strftime("%Y/%m/%d %H時間 %M分")
  end
end
