class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def confirm
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
    @item = Item.find(params[:id])
    # @brand = Brand.find(@item.brand_id)
    @parents = Category.all.order("id ASC").limit(13)
    # @postages = Postage.all.order("id ASC").limit(2)
    # gon.item = @item
    # gon.brand = @brand
    # gon.category = @category
    img_array = []
    @item.images.each do |image|
      img_array.push(image)
    end
    # gon.img_array = img_array
  end

  def update
    @item = Item.find(params[:id])
      # if num_params[:num] != nil
      #   num_params[:num].each do |n|
      #     n = n.to_i
      #     @item.images[n].purge
      #   end
      # end
    # if image_params[:images] != nil
    #   @item.update(image_params)
    # end
    @item.update(update_params)
    redirect_to item_path
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :price, :size, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: :image)
    end

    def update_params
      params.require(:item).permit(:name, :description, :price, :size, :category_id, :condition, :shipping_date, :shipping_price, :shipping_area, :shipping_method, :category_id, :brand_id, :user_id, images_attributes: [:image, :id])
    end
end
