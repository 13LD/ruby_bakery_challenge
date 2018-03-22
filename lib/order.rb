class Order
  require_relative 'item_counter'
  attr_reader :product, :number_of_products
  attr_accessor :min_packets_needed, :cost, :packet_distribution

  def initialize(product, number_of_products)
    raise(ArgumentError, 'Invalid type for product') unless product.is_a?(Product)
    raise(ArgumentError, 'Invalid type for packet count') unless number_of_products.is_a?(Integer)
    @product = product
    @number_of_products = number_of_products
  end

  def self.parse(product, input)
    Order.new(product, Integer(input))
  rescue ArgumentError
    raise ArgumentError, "Invalid input - #{input}"
  end

  def optimal_distribution
    @min_packets_needed, @cost, @packet_distribution = ItemCounter.new(self).get_solution
  end

  def render
    if (min_packets_needed > number_of_products) or cost <= 0
      return puts "Distribution not found"
    end
    puts "#{number_of_products} #{product.code}\t$#{cost.round(2)}"
    packet_distribution.each do |packet_size, packet_count|
      puts  "#{packet_count} X #{packet_size}   $#{ product.pricing_packet[ packet_size ] }"
    end
  end

end