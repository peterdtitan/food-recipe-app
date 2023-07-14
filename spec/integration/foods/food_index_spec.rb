require 'rails_helper'

RSpec.describe 'Food #Index Page', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.create(name: 'sattar', email: 'sattar@mail.com', password: 'sattar')
    sign_in @user
    @food = Food.create(user: @user, name: 'Potatos', measurement_unit: 'kg', quantity: 10, price: 40)
    visit foods_path
  end

  it 'displays the content "Foods" on the UI' do
    expect(page).to have_content('Foods')
  end

  it 'displays the table header "Name" on the UI' do
    expect(page).to have_content('Name')
  end

  it 'displays the table header "Quantity" on the UI' do
    expect(page).to have_content('Quantity')
  end

  it 'displays the table header "Measurement Unit" on the UI' do
    expect(page).to have_content('Measurement Unit')
  end

  it 'displays the table header "Unit Price" on the UI' do
    expect(page).to have_content('Unit Price')
  end

  it 'displays the table header "Actions" on the UI' do
    expect(page).to have_content('Actions')
  end

  it 'I can see food details table' do
    expect(page).to have_content(@food.name)
    expect(page).to have_content(@food.measurement_unit)
    expect(page).to have_content(@food.quantity)
    expect(page).to have_content(@food.price)
    expect(page).to have_content('Delete')
  end

  it 'I can see a button "New food"' do
    expect(page).to have_content('New food')
  end

  it 'When I click on "New food" button, it redirects me to that food\'s new page.' do
    click_link('New food', match: :first)
    expect(page).to have_current_path('/foods/new')
  end
end
