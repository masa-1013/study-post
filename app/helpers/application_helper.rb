module ApplicationHelper
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
