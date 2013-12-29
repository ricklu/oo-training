require_relative '../lib/parking_lot'

class ParkingManager < ParkingBoy
  attr_reader :managed_parking_boys
  def initialize(chooser)
    @managed_parking_boys = []
    super(chooser)
  end

  def manage(parking_boy)
    @managed_parking_boys << parking_boy
  end

  def un_manage(parking_boy)
    @managed_parking_boys.delete_if {|boy|  boy == parking_boy }
  end

  def park_by_boy(car)
    @managed_parking_boys.each do |boy|
      parking_card = boy.park(car)
      return parking_card if parking_card
    end
    return nil
  end

  def pickup_by_boy(parking_card)
    @managed_parking_boys.each do |boy|
      car = boy.pickup(parking_card)
      return car if car
    end
    return nil
  end
end