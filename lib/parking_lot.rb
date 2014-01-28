require_relative '../lib/car'
require_relative '../lib/parking_card'

class ParkingLot
  attr_reader :id, :car_slots

  def initialize(id, capacity)
    @id = id
    @capacity = capacity
    @car_slots = {}
  end

  def park(car)
    if (free_lot > 0)
      card = ParkingCard.new(@id, car.id)
      @car_slots[card] = car
      card
    else
      nil
    end
  end

  def pickup(parking_card)
    car = @car_slots[parking_card]
    if car
      @car_slots.delete parking_card
      car
    else
      nil
    end
  end

  def free_lot
    @capacity - @car_slots.length
  end

  def use_rate
    @capacity == 0 ? 1 : Float(@car_slots.length) / @capacity
  end

  def report(index, logger)
    @car_slots.values.each do |car|
      logger.puts '--' * index + car.id
    end
  end
end