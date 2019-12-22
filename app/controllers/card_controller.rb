class CardController < ApplicationController
  before_action :set_card, only: [:new, :show, :destroy]
  before_action :authenticate_user!

  def new
    redirect_to card_path(@card.id) if @card
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']

    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to complete_signups_path
      else
        redirect_to new_card_path
      end
    end
  end

  def destroy #PayjpとCardデータベースを削除します
    unless @card.blank?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to root_path
  end

  def show #Cardのデータpayjpに送り情報を取り出します
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
    if session[:id] != nil
      @card = Card.where(user_id: session[:id]).first
      sign_in User.find(session[:id]) unless user_signed_in?
    else
      @card = Card.where(user_id: current_user.id).first
    end
  end

end
