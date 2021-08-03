class ShoppingRecord < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :profile
end
