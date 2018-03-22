require_relative 'lib/factory'
require_relative 'lib/product'
require_relative 'lib/order'


def setup_bakery
  factory = Factory.new
  scroll = Product.new( 'Vegemite Scroll', 'VS5' )
  muffin = Product.new( 'Blueberry Muffin', 'MB11' )
  croissant = Product.new( 'Croissant', 'CF' )

  scroll.add_pricing_packet( 3, 6.99 )
  scroll.add_pricing_packet( 5, 8.99 )
  muffin.add_pricing_packet( 2, 9.95 )
  muffin.add_pricing_packet( 5, 16.95 )
  muffin.add_pricing_packet( 8, 24.95 )
  croissant.add_pricing_packet( 3, 5.95 )
  croissant.add_pricing_packet( 5, 9.95 )
  croissant.add_pricing_packet( 9, 16.99 )

  factory.add_product( scroll )
  factory.add_product( muffin)
  factory.add_product( croissant )
  factory
end

def bakery_solution
  bakery = setup_bakery
  bakery.render

  print "\nOrder Details:"
  bakery.products.each do |product|
    begin
      print "\n#{ product.code }: "
      packet_count = STDIN.gets
      order = Order.parse( product, packet_count )
      factory.order_factory( order )
    rescue ArgumentError => e
      puts "Order failed: #{ e.message }"
      puts "Try again for #{product.code}"
      retry
    end
  end

end

bakery_solution