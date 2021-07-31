class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    query = 'SELECT * FROM items order by created_at DESC'
    @items = Item.find_by_sql(query)
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    unless @item.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
  end


  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :status_id, :postage_id, :ship_region_id,
                                 :shipping_date_id, :price).merge(user_id: current_user.id)
  end
end
