require 'product'
require 'order'
require 'item_counter'

describe ItemCounter do
  let(:product) {
    product = Product.new('Vegemite Scroll', 'VS5')
    product.pricing_packet[3], product.pricing_packet[5] = 6.99, 8.99
    product
  }
  let(:order) { Order.new(product, 3) }
  subject(:item_counter) { described_class.new(order)}

  describe "#initialize" do
    it "initializes all values for get_solution method" do
      expect(item_counter.order).to eq(order)
      expect(item_counter.max_packet_count).to eq(4)
      expect(item_counter.min_packets_needed).to eq(Array.new(4,4))
      expect(item_counter.packet_distribution).to eq(Hash.new)
      expect(item_counter.cost).to eq(0)
    end
  end

  describe "#get_solution" do
    it "get_solutions the min_packets_needed for valid order" do
      item_counter.get_solution
      expect(item_counter.min_packets_needed[ 3 ]).to eq(1)
    end

    it "does not get_solution min_packets_needed for invalid order" do
      order = Order.new(product, 4)
      item_counter = ItemCounter.new(order)
      item_counter.get_solution
      expect(item_counter.min_packets_needed[ 4 ]).to eq(5)
    end

    it "calculates total cost for the optimal distribution for valid order" do
      order = Order.new(product, 6)
      item_counter = ItemCounter.new(order)
      item_counter.get_solution
      expect(item_counter.cost).to eq(13.98)
    end

    it "calculates optimal packet_distribution for valid order" do
      order = Order.new(product, 6)
      item_counter = ItemCounter.new(order)
      item_counter.get_solution
      expect(item_counter.packet_distribution).to eq({3 => 2})
    end

    it "fetches the distribution with min_packets_needed incase of multiple possible distributions" do
      order = Order.new(product, 15)
      item_counter = ItemCounter.new(order)
      item_counter.get_solution
      expect(item_counter.packet_distribution).to eq({5 => 3})
      expect(item_counter.packet_distribution).not_to eq({3 => 5})
    end
  end
end