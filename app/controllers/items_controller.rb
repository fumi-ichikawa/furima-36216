class ItemsController < ApplicationController
  
  
  def index
    @items = Item.order("created_at DESC")
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
    params.require(:Item).permit(:title,:description,:category_id,:status_id,:postage_id,:ship_region_id,:shipping_date_id,:price)
  end
end
