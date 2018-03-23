class Product
  attr_reader :name, :code, :pricing_packet

  def initialize(name, code)
    @name = name
    @code = code
    @pricing_packet = Hash.new
  end

  def add_pricing_packet(packet_size, price)
    raise(ArgumentError, 'Invalid pricing packet') unless packet_size.is_a?(Integer) and (price.is_a?(Float) or price.is_a?(Integer))
    raise(ArgumentError, 'Duplicate') if @pricing_packet.key?(packet_size)
    @pricing_packet[ packet_size ] = price
  end

  private

end