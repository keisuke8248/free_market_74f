class Product < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # accepts_nested_attributes_for :brands
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  
  validates :user_id, :name, :description, :status, :category_id, :prefecture_id, :cost, :days, :price, presence: true
end
