class ShoppingRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root_path, only: [:index, :create]

  def index
    @shopping_profile = ShoppingProfile.new
  end

  def create
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
      amount: @item.price,
      card: shopping_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root_path
    redirect_to root_path if current_user == @item.user || @item.shopping_record.present?
  end
end
