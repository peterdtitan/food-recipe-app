require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe 'foods/index.html.erb', type: :view do
    before do
      assign(:foods, [
        FactoryBot.build_stubbed(:food, name: 'Food 1', quantity: 10, measurement_unit: 'kg', price: 5),
        FactoryBot.build_stubbed(:food, name: 'Food 2', quantity: 5, measurement_unit: 'lbs', price: 3)
      ])
    end
  
    it 'displays the food name' do
      render
      expect(rendered).to have_content('Food 1')
      expect(rendered).to have_content('Food 2')
    end
  
    it 'displays the food quantity' do
      render
      expect(rendered).to have_content('10')
      expect(rendered).to have_content('5')
    end
  
    it 'displays the food measurement unit' do
      render
      expect(rendered).to have_content('kg')
      expect(rendered).to have_content('lbs')
    end
  
    it 'displays the food price' do
      render
      expect(rendered).to have_content('$5')
      expect(rendered).to have_content('$3')
    end
  end
