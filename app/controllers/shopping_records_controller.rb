class ShoppingRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @shopping_profile = ShoppingProfile.new
    
    if current_user == @item.user || @item.shopping_record.present?
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @shopping_profile = ShoppingProfile.new(shopping_params)
    if @shopping_profile.valid?
      pay_item
      @shopping_profile.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def shopping_params
    params.require(:shopping_profile).permit(:ship_region_id, :postal_code, :city, :address, :building_name, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: shopping_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
