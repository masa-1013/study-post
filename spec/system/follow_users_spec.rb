require "rails_helper"

describe "ユーザー一覧表示機能" , type: :system do
  let(:user) { FactoryBot.create(:user, name: "user", public: true) } 
  let!(:follower) { FactoryBot.create(:user, name: "follower_user", public: true) } 
  let!(:follow) { FactoryBot.create(:user, name: "follow_user", public: true) } 
  let!(:relation1) { FactoryBot.create(:relationship, follower: user, followed: follow) }
  let!(:relation2) { FactoryBot.create(:relationship, follower: follower, followed: user) }

  before do
    visit login_path
    fill_in "ユーザー名", with: login_user.name
    fill_in "パスワード", with: login_user.password
    click_button "ログイン"
  end

  describe "ユーザー表示" do
    let(:login_user) { user }

    context "フォローユーザー一覧の表示" do
      before do
        visit users_path(name: user.name)
      end

      it "フォローユーザーが表示される" do
        expect(page).to have_content "follow_user"
        expect(page).not_to have_content "follower_user"
      end
    end
    
    context "フォロワーユーザー一覧の表示" do
      before do
        visit users_path(followers: true, name: user.name)
      end

      it "フォロワーユーザーが表示される" do
        expect(page).to have_content "follower_user"
        expect(page).not_to have_content "follow_user"
      end
    end
  end
end