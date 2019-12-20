class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]

  def index
    @items = Item.all.order("id DESC").limit(10)
  end

  def confirm
    @card = Card.where(user_id: current_user.id).first
    @item = Item.find(params[:id])
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
    @address = Address.where(user_id: current_user.id)
  end

  def new
    @item = Item.new
    1.times { @item.images.build }
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @parents = Category.all.order("id ASC").limit(13)
  end

  def update
    if @item.update(update_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(@item.user_id)
    @prefecture = Prefecture.find(@item.shipping_area)
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :price, :size, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: :image).merge(user_id: current_user.id)
    end

    def update_params
      params.require(:item).permit(:name, :description, :price, :size, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: [:image, :id])
    end

    def transact_params
      params.require(:transact).permit(:sold, :confirmation, :evaluat).merge(user_id: current_user.id, item_id: current_item.id)
    end
end
