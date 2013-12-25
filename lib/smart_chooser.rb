class SmartChooser
  def choose(parking_lots)
    parking_lots.values.max { |a, b| a.free_lot <=> b.free_lot }
  end
end