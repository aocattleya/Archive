class CardController < ApplicationController
  before_action :set_card, only: [:new, :show, :destroy]

  def new
    redirect_to card_path(@card.id) if @card
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']

    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      description: '登録テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(@card.id)
      else
        redirect_to new_card_path
      end
    end
  end

  def destroy
    unless @card.blank?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to root_path
  end

  def show
    if @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private
  def set_card
    @card = Card.where(user_id: current_user.id).first
  end

end
