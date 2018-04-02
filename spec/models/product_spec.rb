require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with a name, price, quantity, and category" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Table', price: 500, quantity: 10, category: @category)
      expect(Product.find(@product.id)).not_to be_nil
    end

    it "is not valid without a name" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: nil, price: 500, quantity: 10, category: @category)
      expect(@product.errors.full_messages_for(:name)).to eq ["Name can't be blank"]
    end

    it "is not valid without a price" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Table', price: nil, quantity: 10, category: @category)
      expect(@product.errors.full_messages_for(:price)).to eq ["Price is not a number", "Price can't be blank"]
    end

    it "is not valid without a quantity" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: 'Table', price: 500, quantity: nil, category: @category)
      expect(@product.errors.full_messages_for(:quantity)).to eq ["Quantity can't be blank"]
    end

    it "is not valid without a category" do
      @category = Category.create(name: 'Home')
      @product = Product.create(name: nil, price: nil, quantity: nil, category: nil)
      expect(@product.errors.full_messages_for(:category)).to eq ["Category can't be blank"]
    end

  end
end