class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index] #:showは詳細機能で追加予定

  def index
    # @items = Item.order('created_at DESC') 一覧表示機能実装時に記述予定
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :status_id, :postage_id, :ship_region_id,
                                 :shipping_date_id, :price).merge(user_id: current_user.id)
  end
end
