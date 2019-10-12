require "rails_helper"

describe "勉強記録管理機能", type: :system do
  let(:public_user) { FactoryBot.create(:user, name: "public_user", public: true) } 
  let(:public_user_2) { FactoryBot.create(:user, name: "public_user_2", public: true) } 
  let(:private_user) { FactoryBot.create(:user, name: "private_user") } 
  let!(:public_user_study) { FactoryBot.create(:study, content: "public_user_study", user: public_user) }
  let!(:public_user_study_2) { FactoryBot.create(:study, content: "public_user_study_2", user: public_user_2) }
  let!(:private_user_study) { FactoryBot.create(:study, content: "private_user_study", user: private_user) }

  before do
    visit login_path
    fill_in "ユーザー名", with: login_user.name
    fill_in "パスワード", with: login_user.password
    click_button "ログイン"
  end

  describe "勉強記録公開機能" do
    context "勉強記録の一覧表示" do
      let(:login_user) { public_user }

      before do
        visit studies_path
      end

      it "パブリックユーザーの勉強記録が表示される" do
        expect(page).to have_content "public_user_study"
        expect(page).to have_content "public_user_study_2"
      end

      it "プライベートユーザーの勉強記録が表示されない" do
        expect(page).not_to have_content "private_user_study"
      end
    end
  end

  describe "勉強記録詳細機能" do
    context "パブリックユーザーがログインしている時" do
      let(:login_user) { public_user }

      it "ログインユーザーの勉強記録詳細は表示される" do
        visit study_path(public_user_study)
        expect(page).to have_content "public_user_study"
      end

      it "パブリックユーザー2の勉強記録詳細は表示される" do
        visit study_path(public_user_study_2)
        expect(page).to have_content "public_user_study_2"
      end

      it "プライベートユーザーの勉強記録詳細は表示されない" do
        visit study_path(private_user_study)
        expect(page).not_to have_content "private_user_study"
      end

      it "ログインユーザーの勉強記録詳細に編集、削除ボタンが表示される" do
        visit study_path(public_user_study)
        expect(page).to have_content "編集"
        expect(page).to have_content "削除"
      end

      it "ログインユーザー以外の勉強記録詳細に編集、削除ボタンが表示されない" do
        visit study_path(public_user_study_2)
        expect(page).not_to have_content "編集"
        expect(page).not_to have_content "削除"
      end
    end

    context "プライベートユーザーがログインしている時" do
      let(:login_user) { private_user }

      it "ログインユーザーの勉強記録詳細は表示される" do
        visit study_path(private_user_study)
        expect(page).to have_content "private_user_study"
      end

      it "パブリックユーザーの勉強記録詳細は表示される" do
        visit study_path(public_user_study)
        expect(page).to have_content "public_user_study"
      end
    end
  end
end