class Product
  attr_reader :name, :code, :pricing_packet

  def initialize(name, code)
    @name = name
    @code = code
    @pricing_packet = Hash.new
  end

  def add_pricing_packet(packet_size, price)
    raise(ArgumentError, 'Invalid pricing packet') unless packet_size.is_a?(Integer)
    @pricing_packet[ packet_size ] = price
  end

  private

  #TODO: add method to check packet price type
  
end