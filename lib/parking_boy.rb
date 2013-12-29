require_relative '../lib/parking_lot'

class ParkingBoy
  attr_reader :parking_lots, :is_manager

  def initialize(chooser)
    @chooser = chooser
    @parking_lots = {}
    @is_manager = false
  end

  def park(car)
    parking_lot = choose_parking_lot
    parking_lot.park(car) if parking_lot
  end

  def pickup(parking_card)
    parking_lot = @parking_lots[parking_card.parking_lot_id]
    parking_lot.nil? ? nil : parking_lot.pickup(parking_card)
  end

  def add_parking_lot(parking_lot)
    @parking_lots[parking_lot.id] = parking_lot
  end

  def remove_parking_lot(parking_lot)
    @parking_lots.delete(parking_lot.id)
  end

  def report(index)
    print '--' * (index)
    puts 'Parking Lot:'
    @parking_lots.values.each do |parking_lot|
      parking_lot.report(index + 1)
    end
  end

  def have_cars?
    @parking_lots.values.each do |parking_lot|
      return true if parking_lot.car_slots.size != 0
    end
    return false
  end

  private
  def choose_parking_lot
    @chooser.choose(@parking_lots)
  end
end
