class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  devise :validatable, password_length: 7..128
  has_one :card, dependent: :destroy
  has_one :destination, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :family_name, presence: true, format: {
    with: /\A[ぁ-んァ-ン一-龥]/,
    message: "全角で入力して下さい"
  }
  validates :first_name, presence: true, format: {
    with: /\A[ぁ-んァ-ン一-龥]/,
    message: "全角で入力して下さい"
  }
  validates :family_name_kana, presence: true, format: {
    with: /\A[ぁ-んァ-ン一-龥]/,
    message: "全角で入力して下さい"
  }
  validates :first_name_kana, presence: true, format: {
    with: /\A[ぁ-んァ-ン一-龥]/,
    message: "全角で入力して下さい"
  }
  validates :birth_day, presence: true
end