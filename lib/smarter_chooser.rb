class SmarterChooser
  def choose(parking_lots)
    parking_lots.values.min { |a, b| a.use_rate <=> b.use_rate }
  end
end