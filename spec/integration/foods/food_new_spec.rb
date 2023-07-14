require 'rails_helper'

RSpec.describe 'New food page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'sattar', email: 'sattar@mail.com', password: 'sattar')
    sign_in @user
    visit new_food_path
  end

  it 'displays the content "New food" on the UI' do
    expect(page).to have_content('New food')
  end

  it 'displays the input field for "Name"' do
    expect(page).to have_field('Name')
  end

  it 'displays the input field for "Measurement unit"' do
    expect(page).to have_field('Measurement unit')
  end

  it 'displays the input field for "Price"' do
    expect(page).to have_field('Price')
  end

  it 'displays the input field for "Quantity"' do
    expect(page).to have_field('Quantity')
  end

  it 'displays the link "Back to foods"' do
    expect(page).to have_link('Back to foods', href: foods_path)
  end

  it 'creates a new food with valid data' do
    fill_in 'Name', with: 'Carrots'
    fill_in 'Measurement unit', with: 'kg'
    fill_in 'Price', with: 20
    fill_in 'Quantity', with: 5
    click_button 'Create Food'

    expect(page).to have_content('Food was successfully created.')
    expect(page).to have_content('Carrots')
    expect(page).to have_content('kg')
    expect(page).to have_content('20')
    expect(page).to have_content('5')
  end
end
