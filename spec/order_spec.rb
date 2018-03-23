require 'order'
require 'product'

describe Order do
  let(:product) { Product.new('Vegemite Scroll', 'VS5') }
  subject(:order) { described_class.new(product, 5) }

  describe "#initialize" do
    it "raises exception for invalid type of product" do
      expect{ Order.new("product", 43) }.to raise_exception().with_message('Invalid type for product')
    end

    it "raises exception for invalid type for number_of_products" do
      expect{ Order.new(product, 21.132) }.to raise_exception().with_message('Invalid type for packet count')
    end

    it "initializes order with given product and number_of_products" do
      expect( order.product ).to eq(product)
      expect( order.number_of_products ).to eq(5)
    end
  end

  describe "#parse" do
    it "creates new order object for valid user input for order details" do
      order = Order.parse(product, 10)
      expect(order).to be_an_instance_of(Order)
      expect(order.product).to eq(product)
      expect(order.number_of_products).to eq(10)
    end

    it "does not raise exception for valid order details" do
      expect{ Order.parse(product, 3) }.to_not raise_exception
      expect{ Order.parse(product, 5) }.to_not raise_exception
    end

    it "raises exception for invalid user input for order details" do
      expect{ Order.parse(product, "qwerty") }.to raise_exception().with_message("Invalid input - qwerty")
      expect{ Order.parse(product, "qwerty10") }.to raise_exception().with_message("Invalid input - qwerty10")
    end
  end

end