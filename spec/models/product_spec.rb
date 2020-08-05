require 'rails_helper'

describe Product do
  describe '#create' do
    it "nameとdescription、category_id、status、cost、prefecture_id、days、priceが存在すれば出品できること"  do
      product = build(:product)
      expect(product).to be_valid
    end

    it "nameがない場合は出品できないこと" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "descriptionがない場合は出品できないこと" do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("can't be blank")
    end

    it "category_idがない場合は出品できない" do
      product = build(:product, category_id: nil)
      product.valid?
      expect(product.errors[:category_id]).to include("can't be blank")
    end

    it "statusがない場合は出品できない" do
      product = build(:product, status: nil)
      product.valid?
      expect(product.errors[:status]).to include("can't be blank")
    end

    it "costがない場合は出品できない" do
    product = build(:product, cost: nil)
    product.valid?
    expect(product.errors[:cost]).to include("can't be blank")
    end

    it "prefecture_idがない場合は出品できない" do
    product = build(:product, prefecture_id: nil)
    product.valid?
    expect(product.errors[:prefecture_id]).to include("can't be blank")
    end

    it "daysがない場合は出品できない" do
      product = build(:product, days: nil)
      product.valid?
      expect(product.errors[:days]).to include("can't be blank")
    end

    it "priceがない場合は出品できない" do 
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end
  end
end