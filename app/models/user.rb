class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "無効なメールアドレスです" }
  validates :password_confirmation, presence: true
end
