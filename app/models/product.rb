class Product < ApplicationRecord
  belongs_to :buyer, class_name: "User", optional: true, foreign_key: "buyer_id"
  belongs_to :seller, class_name: "User", optional: true, foreign_key: "seller_id"
  belongs_to :category, optional: true
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :seller_id, :name, :description, :status, :category_id, :prefecture_id, :cost, :days, :price, presence: true
  has_many :comments, dependent: :destroy
end