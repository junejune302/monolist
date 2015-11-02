class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
      response = Amazon::Ecs.item_search(params[:q] ,           
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = response.items
  end

  def show
     @item = Item.find(params[:id])
     @haves = @item.have_users
     @wants = @item.want_users
  end

  private
  def set_item
     @item = Item.find(params[:id])
  end
end
