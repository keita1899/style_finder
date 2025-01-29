require "rails_helper"

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "新規登録" do
    context "ログインしていない場合" do
      before do
        visit new_user_registration_path
      end

      it "ページが表示される" do
        expect(page).to have_title("新規登録 | ItemMatch")
      end

      it "入力が正しいと登録が成功する" do
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password123"
        fill_in "確認用パスワード", with: "password123"
        click_button "登録"

        expect(User.count).to eq(1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("アカウント登録が完了しました。")
        expect(page).to have_link("ログアウト")
      end

      it "入力が間違っていると登録が失敗する" do
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password123"
        fill_in "確認用パスワード", with: "wrongpassword"
        click_button "登録"

        expect(User.count).to eq(0)
        expect(current_path).to eq(user_registration_path)
        expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
      end
    end

    context "ログインしている場合" do
      before do
        user = create(:user)
        sign_in user
      end

      it "Homeページにリダイレクトされる" do
        visit new_user_registration_path
        expect(current_path).to eq(root_path)
      end

      it "フラッシュメッセージが表示される" do
        visit new_user_registration_path
        expect(page).to have_content("すでにログインしています。")
      end
    end
  end
end
