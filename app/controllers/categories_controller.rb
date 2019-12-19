class CategoriesController < ApplicationController
  def index
    @categories = Category.where(ancestry: nil).order("id ASC")
  end

  def show
    @category = Category.find(params[:id])
    @items = Item.where(category_id: params[:id]) if @category.children.length == 0
    ids = @category.children.pluck(:id)
    @items = Item.where(category_id: ids)
  end
end
