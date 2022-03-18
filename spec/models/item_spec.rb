require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できる場合' do
      it '全ての値が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できない場合' do
      it 'imageがなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を選択してください')
      end

      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end

      it 'explainが空では出品できない' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end

      it 'categoryが空では出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end

      it 'categoryに「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end

      it 'conditionが空では出品できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください')
      end

      it 'conditionに「---」が選択されている場合は出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end

      it 'burdenが空では出品できない' do
        @item.burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end

      it 'burdenに「---」が選択されている場合は出品できない' do
        @item.burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end

      it 'prefectureが空では出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
      end

      it 'prefectureに「---」が選択されている場合は出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end

      it 'shipping_dateが空では出品できない' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
      end

      it 'shipping_dateに「---」が選択されている場合は出品できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end

      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください')
      end

      it 'priceは¥300より小さいと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end

      it 'priceは¥9,999,999より大きいと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end

      it 'priceは半角数値以外だと出品できない' do
        @item.price = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it 'userが紐づいていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
