require 'rails_helper'

RSpec.describe 'Shopping List page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'sattar', email: 'sattar@mail.com', password: 'sattar')
    sign_in @user
    visit shopping_list_path
  end

  it 'displays the content "Shopping List" on the UI' do
    expect(page).to have_content('Shopping List')
  end

  it 'displays the amount of food items to buy' do
    expect(page).to have_content('Amount of food items to buy: 0')
  end

  it 'displays the total value of food needed' do
    expect(page).to have_content('Total value of food neeeded: 0')
  end

  it 'displays the food details table' do
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Price')
  end
end
