class ItemsController < ApplicationController
  include ItemsHelper
  respond_to :html, :json

  before_filter :authenticate_user!

  expose(:item, attributes: :item_params)
  expose(:items) { Item.for_user(current_user).public_send(category.pluralize) }
  expose(:project)

  def index
  end

  def create
    respond_to do |format|
      format.js do
        render nothing: true unless item.save
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        item.save
        respond_with item
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        item.destroy
      end
    end
  end

  def sort
    params[:item_panel].each_with_index do |id, index|
      Item.find(id).update_position(index+1)
    end
    render nothing: true
  end

  private

  def item_params
    params[:item].merge!(category: category)
    params.require(:item).permit(:name, :user_id, :category)
  end
end
