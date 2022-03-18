class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:user).order('created_at DESC')
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :explain, :category_id, :condition_id, :burden_id, :prefecture_id,
                                 :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index if @item.buy.present? || (user_signed_in? && current_user.id != @item.user_id)
  end
end
