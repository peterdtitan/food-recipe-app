require 'rails_helper'

RSpec.describe 'shopping_list/index.html.erb', type: :view do
  before do
    assign(:shop_list, [])
    assign(:total_price, 0)
  end

  it 'displays the amount of food items to buy' do
    render
    expect(rendered).to have_content('Amount of food items to buy:')
    expect(rendered).to have_selector('.text-red-400.font-medium', text: '0')
  end


  it 'displays the list of food items' do
    assign(:shop_list, [
      instance_double(RecipeFood, food: instance_double(Food, name: 'Food 1'), quantity: 2, price: 10),
      instance_double(RecipeFood, food: instance_double(Food, name: 'Food 2'), quantity: 1, price: 5)
    ])
    assign(:total_price, 25)

    render

    expect(rendered).to have_content('Food 1')
    expect(rendered).to have_content('Food 2')
    expect(rendered).to have_content('2')
    expect(rendered).to have_content('1')
    expect(rendered).to have_content('$ 10')
    expect(rendered).to have_content('$ 5')
  end

  it 'displays a message when the shopping list is empty' do
    assign(:shop_list, [])

    render

    expect(rendered).to have_content("Don't Need to shop, Everything is available")
  end
end
