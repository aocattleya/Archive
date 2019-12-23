class UsersController < ApplicationController
  before_action :set_user_items, only: [:show, :listing]
  def show
  end

  def listing
  
  end

  private
    def set_user_items
      @user = User.find(params[:id])
      @items = Item.where(user_id: @user.id)
    end
end
