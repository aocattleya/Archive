class TransactsController < ApplicationController

  require 'payjp'

  def buy
    @item = Item.find(params[:id])
    @transact = Transact.new(transact_params)
    @card = Card.where(user_id: current_user.id).first
    if  @transact.save!
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy'
      )
      redirect_to root_path
    else
      binding.pry
      redirect_to item_path
    end
  end

  private

  def transact_params
    params.permit(:user_id , :item_id)
  end
end
