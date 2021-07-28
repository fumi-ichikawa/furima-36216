class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :nickname, presence: true
  validates :birthday, presence: true
  # 全角かな/カナ漢字の制約
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ } do
    validates :last_name, presence: true
    validates :first_name, presence: true
  end
  # カタカナの制約
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
  end
  # パスワード英数字混合
  with_options presence: true, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }, length: { minimum: 6 },
               confirmation: true do
    validates :password
  end
  # # メールアドレスに＠を含む制約
  # with_options presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: '@を含めて入力してください' },
  #              uniqueness: { case_sensitive: false } do
  #   validates :email
  # end
end

# class User < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable

#   validates :nickname, :email, presence: true, uniqueness: { case_sensitive: true }
#   validates :password, presence: true, length: { minimum: 7 }
#   # 漢字と全角の平仮名とカタカナのバリデーション
#   VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
#   validates :family_name, :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角で入力してください" }
#   # 全角カタカナのバリデーション
#   VALID_KANA_NAME_REGEX = /\A[ァ-ヶー－]+\z/
#   validates :family_name_kana, :first_name_kana, presence: true, format: { with: VALID_KANA_NAME_REGEX, message: "は全角カナで入力してください" }

# end
