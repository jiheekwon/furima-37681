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
        expect(@buy_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post-codeは「3桁ハイフン4桁」の半角文字列でないと購入できない' do
        @buy_address.post_code = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Post code is invalid")
      end

      it 'prefectureが空では購入できない' do
        @buy_address.prefecture_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefectureに「---」が選択されている場合は購入できない' do
        @buy_address.prefecture_id = 1
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空では購入できない' do
        @buy_address.municipality = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'house_numberが空では購入できない' do
        @buy_address.house_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空では購入できない' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberは10桁以上11桁以内の半角数値でないと購入できない' do
        @buy_address.phone_number = '123'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'userが紐づいていないと購入できない' do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていないと購入できない' do
        @buy_address.item_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では購入できない" do
        @buy_address.token = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
