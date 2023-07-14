require 'rails_helper'

RSpec.describe 'Shopping List page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'sattar', email: 'sattar@mail.com', password: 'sattar')
    sign_in @user

    visit new_food_path
    fill_in 'Name', with: 'Carrots'
    fill_in 'Measurement unit', with: 'kg'
    fill_in 'Price', with: 40
    fill_in 'Quantity', with: 10
    click_button 'Create Food'
    visit new_recipe_path
    fill_in 'Name', with: 'Curry'
    fill_in 'Preparation time', with: '30'
    fill_in 'Cooking time', with: '45'
    fill_in 'Description', with: 'Delicious curry recipe'
    check 'Public'
    click_button 'Create Recipe'

    click_button 'Add Ingredient'
    fill_in 'Quantity', with: 50
    click_button 'Create Recipe food'
    click_button 'Generate Shopping List'
  end

  it 'displays the shopping list details' do
    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of food items to buy')
  end
end
