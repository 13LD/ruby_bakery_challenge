require 'factory'
require 'product'
require 'order'

describe Factory do
  subject(:factory) { described_class.new }
  let(:product) { Product.new('Vegemite Scroll', 'VS5') }

  describe "#initialize" do
    it "initializes products" do
      expect( factory.products ).to eq(Array.new)
    end
  end

  describe "#add_product" do
    it "adds valid product to factory product list" do
      factory.add_product(product)
      expect( factory.products ).to include(product)
    end

    it "does not raise exception for valid product addition" do
      expect{ factory.add_product(product) }.to_not raise_exception
    end

  end

  describe "#order_factory" do
    it "calls process_optimal_distribution on order instance" do
      expect_any_instance_of(Order).to receive(:optimal_distribution)
      expect_any_instance_of(Order).to receive(:render)
      order = Order.new(product, 2)
      factory.order_factory( order )
    end
  end
end