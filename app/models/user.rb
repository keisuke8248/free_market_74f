class User < ApplicationRecord
  has_one :card, dependent: :destroy
  has_one :destination, dependent: :destroy
  has_many :products, dependent: :destroy
end
