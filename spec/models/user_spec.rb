require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    let!(:user) { build(:user) }

    context "有効な場合" do
      it "バリデーションが成功する" do
        expect(user).to be_valid
      end
    end

    context "無効な場合" do
      it "メールアドレスが空だと失敗する" do
        user.email = nil
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "パスワードが空だと失敗する" do
        user.password = nil
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "確認用パスワードが空だと失敗する" do
        user.password_confirmation = nil
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include("を入力してください")
      end

      it "メールアドレスの形式が間違っていると失敗する" do
        invalid_emails = [
          "invalid_email",
          "@example.com",
          "user@.com",
          "user@example,com",
          "user@example..com",
        ]

        invalid_emails.each do |invalid_email|
          user.email = invalid_email
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("無効なメールアドレスです")
        end
      end

      it "メールアドレスの文字数が256文字以上だと失敗する" do
        user.email = "#{"a" * 244}@example.com"
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("は255文字以内で入力してください")
      end

      it "メールアドレスが重複していると失敗する" do
        create(:user, email: "duplicate@example.com")
        user.email = "duplicate@example.com"
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("はすでに存在します")
      end

      it "パスワードが8文字未満だと失敗する" do
        user.password = "1234567"
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("は8文字以上で入力してください")
      end

      it "パスワードが129文字以上だと失敗する" do
        user.password = "a" * 129
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("は128文字以内で入力してください")
      end

      it "パスワードと確認用パスワードが一致していないと失敗する" do
        user.password = "password123"
        user.password_confirmation = "differentpassword"
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end
