class Items::SearchesController < ApplicationController
  def index
    @items = Item.search(params[:keyword]).order("id DESC")
    @keyword = params[:keyword]
  end
end
