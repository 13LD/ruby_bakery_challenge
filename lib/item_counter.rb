class ItemCounter
  attr_reader :order, :max_packet_count
  attr_accessor :min_packets_needed, :cost, :packet_distribution

  def initialize(order)
    @order = order
    @max_packet_count = order.number_of_products + 1
    @min_packets_needed = Array.new( max_packet_count, max_packet_count )
    @packet_distribution = Hash.new
    @cost = 0
  end

  def get_solution
    optimal_packets_needed
    return min_packets_needed[ order.number_of_products ], cost, packet_distribution
  end


  private

  def optimal_packets_needed
    available_packet_sizes = order.product.pricing_packet.keys
    solution_map = Array.new
    min_packets_needed[ 0 ] = 0
    for products_needed in 1..order.number_of_products
      for packet_size in available_packet_sizes
        if (packet_size <= products_needed)
          tmp = min_packets_needed[ products_needed - packet_size ]
          if (tmp != max_packet_count && tmp + 1 < min_packets_needed[ products_needed ])
            min_packets_needed[ products_needed ] = tmp + 1
            solution_map[ products_needed ] = packet_size
          end
        end
      end
    end
    count_packet_distribution_cost( solution_map, order.number_of_products )
  end


  def count_packet_distribution_cost( solution_map , number_of_products )
    packet_size_used = solution_map[ number_of_products ]
    return if packet_size_used.nil?

    self.packet_distribution[ packet_size_used ] ||= 0
    self.packet_distribution[ packet_size_used ] += 1
    self.cost += order.product.pricing_packet[ packet_size_used ]
    count_packet_distribution_cost( solution_map , number_of_products - packet_size_used )
  end
end