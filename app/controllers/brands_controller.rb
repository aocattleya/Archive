class BrandsController < ApplicationController

  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
    @items = Item.where(brand_id: params[:id]).order("id DESC")
  end

  def search_brand
    @brands = Brand.all.where('name LIKE ?', "%#{params[:keyword]}%")
    respond_to do |format|
      format.json
    end
  end
end
