# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#コンボマスタ用データ
Combmaster.create(id: 1, tag_name: "資格取得")
Combmaster.create(id: 2, tag_name: "スキルアップ")
Combmaster.create(id: 3, tag_name: "TOEIC・TOEFL・英検・英会話")
Combmaster.create(id: 4, tag_name: "外国語取得")
Combmaster.create(id: 5, tag_name: "読書・趣味・教養")
Combmaster.create(id: 6, tag_name: "学問")
Combmaster.create(id: 7, tag_name: "専門学校進学")
Combmaster.create(id: 8, tag_name: "大学受験合格")
Combmaster.create(id: 9, tag_name: "その他")

#ユーザー
User.create(id: 1, name: "山田太郎", password: "test", public: true)
User.create(id: 2, name: "田中太郎", password: "test", public: true)
User.create(id: 3, name: "test", password: "test", public: true)

#勉強記録
200.times do |i|
  month = rand(5..11)
  day = rand(1..30)
  user_id = rand(1..3)
  Study.create(id: i, tag: rand(1..9), content: "サンプルデータ #{i}", time: "#{rand(1..10)}:00", date: "2019-#{month}-#{day}", user_id: user_id)
  (1..3).each do |j|
    Comment.create(content: "コメントサンプルデータ #{j}", user_id: j, study_id: i)
  end
end

#コメント
