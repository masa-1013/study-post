FactoryBot.define do
  factory :study do
    tag { "9" }
    content { "テストデータ" }
    time { "01:00" }
    date { "2019/10/06" }
    user
  end
end