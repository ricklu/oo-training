class SmarterParkingBoy < ParkingBoy

  def park(car)
    parking_lot_with_least_use_rate.park(car)
  end

  private
  def parking_lot_with_least_use_rate
    @parking_lots.values.min { |a, b| a.use_rate <=> b.use_rate }
  end
end