class Dock
            attr_reader :name, 
                        :max_rental_time, 
                        :rental_log 

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @revenue = 0
  end

  def rent(boat, person_renting) 
    boat.rented_by = person_renting
    @rental_log[boat] = person_renting
    boat.rented = true
    
  end

  def rental_log 
    @rental_log
  end

  def charge(boat)
    new_hash = Hash.new
    new_hash[:card_number] = boat.rented_by.credit_card_number
    new_hash[:amount] = ((hours_rented(boat))*boat.price_per_hour)

    return new_hash
  end

  def hours_rented(boat)
    hours = nil 
    if boat.hours_rented <= 3
      hours = boat.hours_rented
    elsif boat.hours_rented > 3
      hours = 3
    end
    return hours 
  end

  def log_hour
    @rental_log.keys.map do |boat|
      if boat.rented 
        boat.hours_rented += 1
      end 
    end
  end

  def revenue 
    boats_to_charge = @rental_log.keys.select do |boat|
      boat.rented == false 
    end 
    boats_to_charge.each do |boat|
      @revenue += charge(boat)[:amount] 
    end
    return @revenue
  end

  def return(boat)
    boat.rented = false 
  end
end