class CategoriesController < ApplicationController
  def index
    @categories = Category.where(ancestry: nil).order("id ASC")
  end

  def show
    @category = Category.find(params[:id])
    if @category.children.length == 0
      @items = Item.where(category_id: params[:id])
      return
    end

    categories = @category.children
    ids = []
    categories.each do |item|
      id = item.children.pluck(:id)
      id.each do |i|
        ids.push(i)
      end
    end
    if ids.length == 0
      ids = @category.children.pluck(:id)
      @items = Item.where(category_id: ids)
    end
    @items = Item.where(category_id: ids)
  end
end
