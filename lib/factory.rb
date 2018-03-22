class Factory
  require_relative 'order'
  attr_reader :products

  def initialize
    @products = Array.new
  end

  def add_product(product)
    @products << product
  end

  def order_factory(order)
    order.optimal_distribution
    order.render
  end

  def render
    puts "\nMENU"
    products.each do |product|
      puts "#{product.name}( #{product.code} )\r"
      product.pricing_packet.each do |packet_size, price|
        puts "\t#{packet_size} - $#{price}"
      end
    end
  end
end