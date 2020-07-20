class Product < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
  belongs_to :category
  belongs_to :brand
end
