require 'rails_helper'

RSpec.describe ShoppingProfile, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @shopping_profile = FactoryBot.build(:shopping_profile, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@shopping_profile).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @shopping_profile.building_name = ''
        expect(@shopping_profile).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空だと保存できないこと' do
        @shopping_profile.token = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと保存できないこと' do
        @shopping_profile.user_id = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと保存できないこと' do
        @shopping_profile.item_id = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空だと保存できないこと' do
        @shopping_profile.postal_code = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include('Postal code はハイフンあり半角数字で入力して下さい')
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @shopping_profile.postal_code = '123456'
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include('Postal code はハイフンあり半角数字で入力して下さい')
      end
      it 'ship_regionが空では登録できないこと' do
        @shopping_profile.ship_region_id = 1
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("Ship region can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @shopping_profile.city = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @shopping_profile.address = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @shopping_profile.phone = ''
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include("Phone can't be blank", 'Phone はハイフンなし半角数字で入力して下さい')
      end
      it 'phoneは10桁以上11桁以内でないと保存できないこと' do
        @shopping_profile.phone = '123456789'
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include
      end
      it 'phoneは半角数字以外は保存できないこと' do
        @shopping_profile.phone = 'ａｂｃｄｅｆｇｈｉｊ'
        @shopping_profile.valid?
        expect(@shopping_profile.errors.full_messages).to include('Phone はハイフンなし半角数字で入力して下さい')
      end
    end
  end
end
