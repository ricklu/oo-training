class NormalChooser
  def choose(parking_lots)
    parking_lots.select { |_, parking_lot| parking_lot.free_lot > 0 }.values.first
  end
end