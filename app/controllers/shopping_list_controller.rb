class ShoppingListController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def index
    @shop_list = RecipeFood.shopping_list(current_user)

    @total_price = @shop_list.reduce(0) { |sum, item| sum + item.price }
  end
end
