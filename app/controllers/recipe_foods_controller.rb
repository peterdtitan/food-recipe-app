class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @foods = Food.where(user: current_user)
    @recipe = Recipe.find(params[:recipe_id])
  end

  def show; end

  def create
    recipe = Recipe.find(params[:recipe_id])
    food = Food.find(params[:recipe_food][:id])

    existing_recipe_food = RecipeFood.find_by(recipe:, food:)

    if existing_recipe_food
      existing_recipe_food.update(quantity: existing_recipe_food.quantity + recipe_food_params[:quantity].to_i)
      redirect_to recipe_path(recipe), notice: 'Ingredient quantity has been updated successfully!'
    else
      @recipe_food = RecipeFood.new(recipe_food_params)
      @recipe_food.recipe = recipe
      @recipe_food.food = food

      if @recipe_food.save
        redirect_to recipe_path(recipe), notice: 'Ingredient has been added successfully!'
      else
        redirect_to recipe_path(recipe), notice: 'Error occurred while adding the ingredient.'
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_url(params[:recipe_id]), notice: 'Ingredient was successfully destroyed.'
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @foods = Food.where(user: current_user)
    @recipe = Recipe.find(params[:recipe_id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.update(recipe_food_params)
    redirect_to recipe_path(@recipe_food.recipe), notice: 'Ingredient was successfully updated.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity)
  end
end
