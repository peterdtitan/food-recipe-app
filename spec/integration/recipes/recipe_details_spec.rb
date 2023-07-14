require 'rails_helper'

RSpec.describe 'Shopping List page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'sattar', email: 'sattar@mail.com', password: 'sattar')
    sign_in @user

    visit new_recipe_path

    fill_in 'Name', with: 'Curry'
    fill_in 'Preparation time', with: '30'
    fill_in 'Cooking time', with: '45'
    fill_in 'Description', with: 'Delicious curry recipe'
    check 'Public'
    click_button 'Create Recipe'
  end

  it 'check displays the content "Preparation time" on the UI' do
    expect(page).to have_content('Preparation time')
  end

  it 'check displays the content "Cooking time" on the UI' do
    expect(page).to have_content('Cooking time')
  end

  it 'check displays the content "Description" on the UI' do
    expect(page).to have_content('Description')
  end

  it 'check displays the content "Generate Shopping List" on the UI' do
    expect(page).to have_content('Generate Shopping List')
  end

  it 'check displays the content "Add Ingredient" on the UI' do
    expect(page).to have_content('Add Ingredient')
  end

  it 'check displays the table header "Food" on the UI' do
    expect(page).to have_content('Food')
  end

  it 'check displays the table header "Quantity" on the UI' do
    expect(page).to have_content('Quantity')
  end

  it 'check displays the table header "Value" on the UI' do
    expect(page).to have_content('Value')
  end

  it 'check displays the table header "Actions" on the UI' do
    expect(page).to have_content('Actions')
  end

  it 'check displays the table header "Food" on the UI' do
    expect(page).to have_content('Food')
  end
end
