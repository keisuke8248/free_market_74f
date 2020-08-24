class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  devise :validatable, password_length: 7..128
  has_one :card, dependent: :destroy
  has_one :destination, dependent: :destroy
  has_many :buyer_records,   class_name: 'Product', foreign_key: 'buyer_id', dependent: :destroy
  has_many :seller_records,   class_name: 'Product', foreign_key: 'seller_id', dependent: :destroy
  has_many :sns_credentials

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
  has_many :comments, dependent: :destroy

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
