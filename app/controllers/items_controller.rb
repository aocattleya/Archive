class ItemsController < ApplicationController
  def index
  end
  def confirm
  end
  def new
    @item = Item.new
    5.times { @item.images.build }
    @parents = Category.all.order("id ASC").limit(13)
  end
  def create
    @item = Item.create(item_params)
    # user_id = current_user.id
    # @item.save!
  end
  private
    def item_params
      params.require(:item).permit(:name, :description, :price, :size, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: [:id, :image])
    end
end