class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "無効なメールアドレスです" }
  validates :password_confirmation, presence: true

  validate :password_complexity

  has_many :recognitions, dependent: :destroy

  private

    def password_complexity
      return if password.blank?

      unless password.match?(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/)
        errors.add :password, I18n.t("errors.messages.password_complexity")
      end
    end
end
