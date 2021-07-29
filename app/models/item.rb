class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :ship_region
  belongs_to :shipping_date

  with_options presence: true do
    validates :title
    validates :description
    validates :price, inclusion: { in: (300..9999999)}
  end

  #ジャンルの選択が「--」の時は保存できないようにする
  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :ship_region_id
    validates :shipping_date_id
  end

  belongs_to :user
  has_one_attached :image
end
