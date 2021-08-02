class ShoppingProfile
  include ActiveModel::Model

  attr_accessor :postal_code, :ship_region_id, :city, :address, :building_name, :phone, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンあり半角数字で入力して下さい' }
    validates :city
    validates :address
    validates :phone, numericality: { with: /\A\d{10,11}\z/, message: 'はハイフンなし半角数字で入力して下さい' }
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :ship_region_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    shopping_record = ShoppingRecord.create(user_id: user_id, item_id: item_id)
    Profile.create(postal_code: postal_code, ship_region_id: ship_region_id, city: city, address: address,
                   building_name: building_name, phone: phone, shopping_record_id: shopping_record.id)
  end
end
