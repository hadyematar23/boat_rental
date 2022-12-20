class Boat
      attr_reader :type, 
                  :price_per_hour 
                  
      attr_accessor :rented_by, 
                    :rented,
                    :hours_rented

  def initialize(type, price_per_hour)
    @type = type
    @price_per_hour = price_per_hour
    @hours_rented = 0 
    @rented_by = nil 
    @rented = false
    
  end

  def add_hour
    @hours_rented += 1
  end
end