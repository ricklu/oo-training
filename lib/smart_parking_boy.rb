class SmartParkingBoy < ParkingBoy

  def park(car)
    parking_lot_with_max_free_lots.park(car)
  end

  private
  def parking_lot_with_max_free_lots
    @parking_lots.values.max { |a, b| a.free_lot <=> b.free_lot }
  end
end