require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :view do
  before do
    assign(:recipes, [
      FactoryBot.build_stubbed(:recipe, name: 'Recipe 1', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      FactoryBot.build_stubbed(:recipe, name: 'Recipe 2', description: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem.'),
    ])
    render
  end

  it 'displays the recipe name' do
    expect(rendered).to have_content('Recipe 1')
    expect(rendered).to have_content('Recipe 2')
  end

  it 'displays a truncated recipe description' do
    expect(rendered).to have_selector('.rounded-md p', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    expect(rendered).to have_selector('.rounded-md p', text: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem.')
  end
end
