require 'rails_helper'

RSpec.feature "Visitor can navigate from home page to the product page by clicking on a product", type: :feature, js: true do


  before :each do
    @category = Category.create! name: 'Apparel'

   10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
   end
  end

  scenario "They see the product details" do
    visit root_path
    # commented out b/c it's for debugging only
    # save_and_open_screenshot
    first("article.product").find_link('Details').click
    expect(page).to have_css '.products-show'
  end
end
