require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successful when all fields are implemented' do
      @product = Product.new
      @product.name = 'Book'
      @product.price = 15
      @product.quantity = 8
      @product.category_id = 1

      expect(@product).to be_present
    end

    it 'should fail when a name is missing' do
      @product = Product.new
      @product.name = nil
      @product.price = 15
      @product.quantity = 8
      @product.category_id = 1

      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should fail when price is missing' do
      @product = Product.new
      @product.name = 'Book'
      @product.price = nil
      @product.quantity = 8
      @product.category_id = 1

      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should fail when quantity is missing' do
      @product = Product.new
      @product.name = 'Book'
      @product.price = 15
      @product.quantity = nil
      @product.category_id = 1

      @product.save

      expect(@product.errors.full_messages).to include ("Quantity can't be blank")
    end

    it 'should fail when category is missing' do
      @product = Product.new
      @product.name = 'Book'
      @product.price = 15
      @product.quantity = 8
      @product.category_id = nil

      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")

    end

  end
end