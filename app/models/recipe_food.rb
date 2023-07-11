class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def value
    return 'Opps! No Food Found' unless food

    food.price * quantity
  end

  def self.total_price(recipe_foods)
    recipe_foods.sum(&:value)
  end

  def self.shopping_list
    recipe_foods = RecipeFood.joins(:food)
      .select('recipe_foods.food_id, foods.name, foods.price, SUM(recipe_foods.quantity) as quantity')
      .group('recipe_foods.food_id, foods.name, foods.price')

    shop_list = []

    recipe_foods.each do |recipe_food|
      food = Food.find_by(id: recipe_food.food_id)
      next unless food

      recipe_food.quantity -= food.quantity
      recipe_food.price *= recipe_food.quantity

      shop_list << recipe_food if recipe_food.quantity.positive?
    end
    shop_list
  end
end
