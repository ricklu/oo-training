require_relative '../lib/parking_lot'

class ParkingBoy
  attr_reader :parking_lots, :managed_parking_boys

  def initialize(chooser)
    @managed_parking_boys = []
    @chooser = chooser
    @parking_lots = {}
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

  def manage(parking_boy)
    @managed_parking_boys << parking_boy
  end

  def un_manage(parking_boy)
    @managed_parking_boys.delete_if { |boy| boy == parking_boy }
  end

  def report(index = 0)
    Reporter.report(index, @managed_parking_boys, @parking_lots)
  end

  private
  def choose_parking_lot
    parking_lot = @chooser.choose(@parking_lots)
    return parking_lot if not parking_lot.nil?
    @managed_parking_boys.each do |boy|
      parking_lot = boy.choose_parking_lot
      return parking_lot if not parking_lot.nil?
    end
    return nil
  end
end
