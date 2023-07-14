require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'sattar', email: 'sattar@mail.com', password: 'sattar')
    sign_in @user
  end

  it 'displays the content "Recipes" on the UI' do
    visit recipes_path
    expect(page).to have_content('Recipes')
  end

  it 'allows creating a new recipe and shows it on the index page' do
    visit recipes_path

    click_link('New recipe', match: :first)
    expect(page).to have_current_path(new_recipe_path)

    fill_in 'Name', with: 'Curry'
    fill_in 'Preparation time', with: '30'
    fill_in 'Cooking time', with: '45'
    fill_in 'Description', with: 'Delicious curry recipe'
    check 'Public'
    click_button 'Create Recipe'

    click_link('Back to recipes')
    expect(page).to have_content('Curry')
    expect(page).to have_content('Delicious curry recipe')
    expect(page).to have_content('Remove')
    expect(page).to have_content('See Details')

    click_link('See Details', match: :first) # Assuming you want to go to the details page of the first recipe
    expect(page).to have_current_path(recipe_path(Recipe.first)) # Updated this line
  end
end
