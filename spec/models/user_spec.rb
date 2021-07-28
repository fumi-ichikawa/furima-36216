require 'rails_helper'

describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
          expect(@user).to be_valid
        end

        it 'passwordが6文字以上,英数字混合であれば登録できること' do
          @user.password = 'ab0000'
          @user.password_confirmation = 'ab0000'
          expect(@user).to be_valid
        end
      end
      context '新規登録できないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname =''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空では登録できないこと' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it '重複したemailが存在する場合登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'passwordが空では登録できないこと' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'passwordが5文字以下であれば登録できないこと' do
          @user.password = 'ab000'
          @user.password_confirmation = 'ab000'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end

        it 'passwordとpassword_confirmationが不一致では登録できないこと' do
          @user.password = '1234ab'
          @user.password_confirmation = '12345ab'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'passwordが半角英数混合以外では登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
        end
      end
    end

    describe '本人情報確認' do

      context '新規登録できるとき' do

        it 'last_name,first_name,last_name_kana,first_name_kana,birthdayが存在すれば登録できること' do
          expect(@user).to be_valid
        end

        it 'last_nameが全角であれば登録できること' do
          @user.last_name = '山田'
          expect(@user).to be_valid
        end

        it 'first_nameが全角であれば登録できること' do
          @user.first_name = '太郎'
          expect(@user).to be_valid
        end

        it 'last_name_kanaが全角カナであれば登録できること' do
          @user.last_name_kana = 'ヤマダ'
          expect(@user).to be_valid
        end

        it 'first_name_kanaが全角カナであれば登録できること' do
          @user.last_name_kana = 'タロウ'
          expect(@user).to be_valid
        end
      end

      context '新規登録できないとき' do

        it 'last_nameが空では登録できないこと' do
          @user.last_name =''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
        end

        it 'first_nameが空では登録できないこと' do
          @user.first_name =''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
        end

        it "last_name_kanaが空だと登録できない" do
          @user.last_name_kana =''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
        end

        it "first_name_kanaが空だと登録できない" do
          @user.first_name_kana =''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
        end

        it 'last_nameを半角で入力した時登録できない' do
          @user.last_name ='ﾐｮｳｼﾞ'
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name is invalid")
        end

        it 'first_nameを半角で入力した時登録できない' do
          @user.first_name ='ﾅﾏｴ'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name is invalid")
        end

        it 'last_name_kanaをカタカナ以外で入力した時登録できない' do
          @user.last_name_kana ='kana'
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana is invalid")
        end

        it 'first_name_kanaをカタカナ以外で入力した時登録できない' do
          @user.first_name_kana ='kana'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana is invalid")
        end

        it '誕生日が空では登録できない' do
          @user.birthday =''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
