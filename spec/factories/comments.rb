FactoryBot.define do
  factory :comment do
    text { "コメントテスト" }
    study
    user
  end
end