class NormalChooser
  def choose(managed_parking_boys = [], parking_lots)
    parking_lot = parking_lots.select { |_, parking_lot| parking_lot.free_lot > 0 }.values.first
    return parking_lot if not parking_lot.nil?

    managed_parking_boys.each do |boy|
      parking_lot = boy.choose_parking_lot_to_park
      return parking_lot if not parking_lot.nil?
    end
    return nil
  end
end