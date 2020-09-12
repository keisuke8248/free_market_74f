class Product < ApplicationRecord
  belongs_to :buyer, class_name: "User", optional: true, foreign_key: "buyer_id"
  belongs_to :seller, class_name: "User", optional: true, foreign_key: "seller_id"
  belongs_to :category, optional: true
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :seller_id, :name, :description, :status, :category_id, :prefecture_id, :cost, :days, :price, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  validates :images, length: { minimum: 1, maximum: 10, message: "の数が不正です" }
  
  def self.search(search)
    if search
      Product.where('name LIKE(?)', "%#{search}%")
    else
      Product.all
    end
  end 
end

  def text_placeholder
    <<-"EOS".strip_heredoc
      商品の説明(必須 1,000文字以内)
      (色、素材、重さ、定価、注意点など)

      例) 2010年頃に1万円で購入したジャケットです。ライトグレーで傷はありません。合わせやすいのでおすすめです。
    EOS
  end
