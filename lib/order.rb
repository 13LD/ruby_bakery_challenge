class Order
  attr_reader :product, :number_of_products
  attr_accessor :min_packets_needed, :cost

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

  #TODO: optimal_distribution method, add packet_distribution
  #TODO: render order details (package lists)
end