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

      it "新規登録ページが表示される" do
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

  describe "ログイン" do
    let!(:user) { create(:user, email: "test@example.com", password: "password123") }

    context "ログインしていない場合" do
      before { visit new_user_session_path }

      it "ログインページが表示される" do
        expect(page).to have_title("ログイン | ItemMatch")
      end

      it "入力が正しいとログインが成功する" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("ログインしました。")
        expect(page).to have_link("ログアウト")
      end

      it "メールアドレスが間違っているとログインが失敗する" do
        fill_in "メールアドレス", with: "wrong@example.com"
        fill_in "パスワード", with: "password123"
        click_button "ログイン"

        expect(current_path).to eq(user_session_path)
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end

      it "パスワードが間違っているとログインが失敗する" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "wrongpassword"
        click_button "ログイン"

        expect(current_path).to eq(user_session_path)
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        visit new_user_session_path
      end

      it "Homeページにリダイレクトされる" do
        expect(current_path).to eq(root_path)
      end

      it "フラッシュメッセージが表示される" do
        expect(page).to have_content("すでにログインしています。")
      end
    end
  end

  describe "ログアウト" do
    let!(:user) { create(:user, email: "test@example.com", password: "password123") }

    before do
      sign_in user
    end

    it "ログアウトボタンをクリックするとログアウトが成功する" do
      visit root_path
      click_link "ログアウト"

      expect(current_path).to eq(user_session_path)
      expect(page).to have_content("ログアウトしました。")
      expect(page).to have_link("ログイン")
    end
  end
end
