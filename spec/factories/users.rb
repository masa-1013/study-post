FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    password { "password" }
    public { false }
  end
end