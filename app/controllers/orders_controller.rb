class OrdersController < ApplicationController
  before_action :move_to_index, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @buy_address = BuyAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buy_address = BuyAddress.new(order_params)
    if @buy_address.valid?
      pay_item
      @buy_address.save
      redirect_to root_path
    else
      render :index
    end
  end


  private
  def move_to_index
    item = Item.find(params[:item_id])
    if item.buy.present? || (user_signed_in? && current_user.id == item.user_id)
      redirect_to root_path
    end
  end

  def order_params
    params.require(:buy_address).permit(:post_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end
end