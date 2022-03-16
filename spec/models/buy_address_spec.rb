require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @buy_address = FactoryBot.build(:buy_address, user_id: user.id, item_id: item.id)
    sleep(1)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@buy_address).to be_valid
      end

      it 'building_nameが空でも購入できる' do
        @buy_address.building_name = ''
        expect(@buy_address).to be_valid
      end
    end

    context '商品購入できない場合' do
      it 'post-codeが空では購入できない' do
        @buy_address.post_code = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'post-codeは「3桁ハイフン4桁」の半角文字列でないと購入できない' do
        @buy_address.post_code = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'prefectureが空では購入できない' do
        @buy_address.prefecture_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'prefectureに「---」が選択されている場合は購入できない' do
        @buy_address.prefecture_id = 1
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'municipalityが空では購入できない' do
        @buy_address.municipality = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'house_numberが空では購入できない' do
        @buy_address.house_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では購入できない' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberは10桁以上11桁以内の半角数値でないと購入できない' do
        @buy_address.phone_number = '123'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberが12桁以上では購入できない' do
        @buy_address.phone_number = '111111111111'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'userが紐づいていないと購入できない' do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐づいていないと購入できない' do
        @buy_address.item_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Itemを入力してください")
      end

      it "tokenが空では購入できない" do
        @buy_address.token = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

    end
  end
end
