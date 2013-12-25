require_relative '../lib/parking_lot'

class ParkingBoy
  attr_reader :parking_lots

  def initialize(chooser)
    @chooser = chooser
    @parking_lots = {}
  end

  def park(car)
    parking_lot = choose_parking_lot
    p parking_lot
    parking_lot.park(car) if parking_lot != nil
  end

  def pickup(parking_card)
    parking_lot = @parking_lots[parking_card.parking_lot_id]
    parking_lot.nil? ? nil : parking_lot.pickup(parking_card)
  end

  def free_lots
    @parking_lots.values.inject(0) { |sum, parking_lot| sum + parking_lot.free_lot }
  end

  def add_parking_lot(parking_lot)
    @parking_lots[parking_lot.id] = parking_lot
  end

  def remove_parking_lot(parking_lot)
    @parking_lots.delete(parking_lot.id)
  end

  private
  def choose_parking_lot
    @chooser.choose(@parking_lots)
  end
end
