class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @buy_address = BuyAddress.new
  end

  def create
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if @item.buy.present? || (user_signed_in? && current_user.id == @item.user_id)
  end

  def order_params
    params.require(:buy_address).permit(:post_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
