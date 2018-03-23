require 'product'

describe Product do
  subject(:product) { described_class.new('Vegemite Scroll', 'VS5') }

  describe "#initialize" do
    it "initializes pricing hash" do
      expect( product.name ).to eq('Vegemite Scroll')
      expect( product.code ).to eq('VS5')
      expect( product.pricing_packet ).to eq(Hash.new)
    end
  end

  describe "#add_pricing" do
    it "adds valid pricing to product" do
      pricing_packet = product.add_pricing_packet(10, 2.5)
      expect( product.pricing_packet ).to include(10 => 2.5)
    end

    it "raises exception for invalid type of packet_size for pricing packets" do
      expect { product.add_pricing_packet(10.5, 14) }
          .to raise_exception().with_message('Invalid pricing packet')
    end

    it "raises exception for invalid type of price for pricing packets" do
      expect { product.add_pricing_packet(2, "2") }
          .to raise_exception().with_message('Invalid pricing packet')
    end

    it "raises exception for duplicate pricing packets" do
      product.add_pricing_packet(2, 1.6)
      expect{ product.add_pricing_packet(2, 1.5) }.to raise_exception()
                                                   .with_message('Duplicate')
    end

  end
end