class ItemsController < ApplicationController
  before_action :set_item, only: [:confirm, :edit, :update, :show, :destroy]

  def index
    items = Item.all.order("id DESC")
    items1 = []
    items2 = [].take(10)
    items3 = [].take(10)
    items4 = [].take(10)
    items.each do |item|
      if item.category.parent.parent.id == 1
        items1.push(item)
      elsif item.category.parent.parent.id == 2
        items2.push(item)
      elsif item.category.parent.parent.id == 8
        items3.push(item)
      elsif item.category.parent.parent.id == 6
        items4.push(item)
      end
    end
    @items1 = items1.first(10)
    @items2 = items2.first(10)
    @items3 = items3.first(10)
    @items4 = items4.first(10)

    items5 = []
    items6 = [].take(10)
    items7 = [].take(10)
    items8 = [].take(10)
    items.each do |item|
      if item.brand_id == 1
        items5.push(item)
      elsif item.brand_id == 2
        items6.push(item)
      elsif item.brand_id == 3
        items7.push(item)
      elsif item.brand_id == 4
        items8.push(item)
      end
    end
    @items5 = items5.first(10)
    @items6 = items6.first(10)
    @items7 = items7.first(10)
    @items8 = items8.first(10)
  end

  def confirm
    @card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
    @address = Address.where(user_id: current_user.id)
  end

  def new
    if user_signed_in?
      @item = Item.new
      1.times { @item.images.build }
      @parents = Category.all.order("id ASC").limit(13)
      ids = [14..159]
      @children = Category.where(id: ids)
    else
      redirect_to root_path
    end
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
    @item = Item.find(params[:id])
    if @item.user_id == current_user.id
      @parents = Category.all.order("id ASC").limit(13)

      @category_parent_array = []
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent
      end

      @category_child_array = @item.category.parent.parent.children

      @category_grandchild_array = @item.category.parent.children
    else
      redirect_to item_path(@item)
    end
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
      params.require(:item).permit(:name, :description, :price, :size, :brand_id, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: :image).merge(user_id: current_user.id)
    end

    def update_params
      params.require(:item).permit(:name, :description, :price, :size, :brand_id, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: [:image, :id])
    end

    def transact_params
      params.require(:transact).permit(:sold, :confirmation, :evaluat).merge(user_id: current_user.id, item_id: current_item.id)
    end
end
