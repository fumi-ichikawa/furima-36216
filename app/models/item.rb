class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :ship_region
  belongs_to :shipping_date

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :price, inclusion: { in: (300..9_999_999) }
  end

  # ジャンルの選択が「--」の時は保存できないようにする
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :ship_region_id
    validates :shipping_date_id
  end

  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力して下さい' }

  belongs_to :user
  has_one_attached :image
  # has_one :shopping_record 　←　商品購入機能実装時に記述予定
end
