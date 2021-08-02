class ShoppingProfile
  include ActiveModel::Model

  attr_accessor :postal_code, :ship_region_id, :city, :address, :building_name, :phone, :shopping_record_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :address
    validates :phone
    validates :user_id
    validates :item_id
    validates :token

  end

  validates :ship_region_id, numericality: { other_than: 1, message: "can't be blank" }

  with_options numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力して下さい' } do
    validates :postal_code
    validates :phone
  end

  def save
    shopping_record = Shopping_record.create(user_id: current_user.id, item_id: item_id)
    Profile.create( postal_code: postal_code, ship_region_id: ship_region_id, city: city, address: address, building_name: building_name, phone: phone, shopping_record_id: shopping_record.id)
  end
end