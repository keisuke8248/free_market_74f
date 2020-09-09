require 'rails_helper'
describe Card do
  describe '#pay' do
    it "userテーブルのレコードに対応するuser_id、customer_idとcard_idがあれば登録できること" do
      user = create(:user)
      card = build(:card, user_id: user.id)
      expect(card).to be_valid
    end
    it "customer_idがない場合は登録できないこと" do
      card = build(:card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    it "card_idがない場合は登録できないこと" do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end