require 'rails_helper'

RSpec.describe Item, type: :model do
  
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '出品新規登録' do

      context '新規登録できるとき' do

        it '全ての項目が入力されていれば登録できること' do
          expect(@item).to be_valid
        end
        it 'priceが300円以上10000000円以下で登録できること' do
          @item.price = 300
          expect(@item).to be_valid
        end

      end
    
      context '新規登録できないとき' do

        it 'titleが空では登録できないこと' do
          @item.title = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Title can't be blank")
        end

        it 'discriptionが空では登録できないこと' do
          @item.description = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end

        it 'categoryが空では登録できないこと' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end

        it 'statusが空では登録できないこと' do
          @item.status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Status can't be blank")
        end

        it 'postageが空では登録できないこと' do
          @item.postage_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Postage can't be blank")
        end

        it 'ship_regionが空では登録できないこと' do
          @item.ship_region_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Ship region can't be blank")
        end

        it 'shipping_dateが空では登録できないこと' do
          @item.shipping_date_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping date can't be blank")
        end

        it 'priceが空では登録できないこと' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not included in the list")
        end

        it 'priceが300円未満では登録できないこと' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is not included in the list")
        end

        it 'priceが10000000円以上では登録できないこと' do
          @item.price = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is not included in the list")
        end

      end
    end
  end
end
