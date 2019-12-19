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

  def get_child_category
    respond_to do |format|
      format.html
      format.json do
        @childs = Category.find(params[:parent_id]).children
      end
    end
  end

  def get_grandchild_category
    respond_to do |format|
      format.html
      format.json do
        @grandchilds = Category.find(params[:child_id]).children
      end
    end
  end
end
