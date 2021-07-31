class ShoppingRecordsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @shopping_record = ShoppingRecord.new
  end

  def create
    @item = Item.find(params[:item_id])
    @shopping_record = ShoppingRecord.new(order_params)
    if @shopping_record.valid?
      @shopping_record.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:shopping_record).permit(:nickname, :email, :encrypted_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, :image, :title, :description, :category_id, :status_id, :postage_id, :ship_region_id, :shipping_date_id, :price, :postal_code, :city, :address, :building_name, :phone)
  end
end
