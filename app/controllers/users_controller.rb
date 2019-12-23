class UsersController < ApplicationController
  before_action :set_user_items, only: [:show, :listing]
  before_action :valid_user, only: [:show, :listing]

  def show
    redirect_to root_path unless @user == current_user
  end

  def listing
    redirect_to root_path unless @user == current_user
  end

  private

    def valid_user
      redirect_to root_path unless @user == current_user
    end

    def set_user_items
      @user = User.find(params[:id])
      @items = Item.where(user_id: @user.id)
    end
end
