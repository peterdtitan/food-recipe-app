require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { User.create(name: 'John Doe', email: 'doe@gmail.com', password: '123456') }
  let(:food) { Food.create(name: 'Ingredient', price: 10, measurement_unit: 'unit', quantity: 1, user_id: user.id) }
  let(:recipe) { Recipe.create(name: 'Recipe', preparation_time: 30, cooking_time: 60, description: 'Delicious recipe', public: true, user_id: user.id) }
  let(:recipe_food) { RecipeFood.create(recipe_id: recipe.id, food_id: food.id, quantity: 2) }

  describe 'GET #new' do
    it 'assigns a new recipe_food' do
      get :new, params: { recipe_id: recipe.id }
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end

    it 'assigns the recipe' do
      get :new, params: { recipe_id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it 'renders the new template' do
      get :new, params: { recipe_id: recipe.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { recipe_id: recipe.id, recipe_food: { id: food.id, quantity: 3 } } }

      it 'creates a new recipe_food' do
        expect {
          post :create, params: valid_params
        }.to change(RecipeFood, :count).by(1)
      end

      it 'assigns the created recipe_food' do
        post :create, params: valid_params
        expect(assigns(:recipe_food)).to be_a(RecipeFood)
        expect(assigns(:recipe_food)).to be_persisted
      end

      it 'redirects to the recipe' do
        post :create, params: valid_params
        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'sets a flash notice message' do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Ingredient has been added successfully!')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { recipe_id: recipe.id, recipe_food: { id: food.id, quantity: -1 } } }

      it 'does not create a new recipe_food' do
        expect {
          post :create, params: invalid_params
        }.to_not change(RecipeFood, :count)
      end

      it 'redirects to the recipe' do
        post :create, params: invalid_params
        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'sets a flash notice message' do
        post :create, params: invalid_params
        expect(flash[:notice]).to eq('Error occurred while adding the ingredient.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the recipe_food' do
      recipe_food # Create the recipe_food
      expect {
        delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      }.to change(RecipeFood, :count).by(-1)
    end

    it 'redirects to the recipe' do
      delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to redirect_to(recipe_url(recipe))
    end

    it 'sets a flash notice message' do
      delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(flash[:notice]).to eq('Ingredient was successfully destroyed.')
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested recipe_food' do
      get :edit, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(assigns(:recipe_food)).to eq(recipe_food)
    end

    it 'assigns the recipe' do
      get :edit, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it 'renders the edit template' do
      get :edit, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:update_params) { { recipe_id: recipe.id, id: recipe_food.id, recipe_food: { quantity: 5 } } }

    it 'updates the recipe_food' do
      patch :update, params: update_params
      recipe_food.reload
      expect(recipe_food.quantity).to eq(5)
    end

    it 'redirects to the recipe' do
      patch :update, params: update_params
      expect(response).to redirect_to(recipe_path(recipe))
    end

    it 'sets a flash notice message' do
      patch :update, params: update_params
      expect(flash[:notice]).to eq('Ingredient was successfully updated.')
    end
  end
end
