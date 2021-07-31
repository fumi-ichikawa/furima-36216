class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string     :postal_code,        null: false
      t.integer    :ship_region_id,     null: false
      t.string     :city,               null: false
      t.string     :address,            null: false
      t.string     :building_name
      t.string     :phone,              null: false
      t.references :shopping_record,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
