class ShoppingListController < ApplicationController
  def index
    @shop_list = RecipeFood.shopping_list

    @total_price = @shop_list.reduce(0) { |sum, item| sum + item.price }
  end
end
