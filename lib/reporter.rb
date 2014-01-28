require_relative '../lib/parking_boy'

class Reporter
  def report(index = 0, managed_parking_boys = [], parking_lots = {}, logger = $stdout)
    logger.puts 'Parking Manager Report:' if index == 0

    logger.puts '--' * (index + 1) + 'Parking Manager'
    managed_parking_boys.each do |boy|
      if boy.managed_parking_boys.length > 0
        boy.report(index + 1, logger)
      end
    end

    logger.puts '--' * (index + 1) + 'Parking Boy'
    managed_parking_boys.each do |boy|
      if boy.managed_parking_boys.length == 0
        boy.report(index + 1, logger)
      end
    end

    logger.puts '--' * (index + 1) + 'Parking Lot:'
    parking_lots.values.each do |parking_lot|
      parking_lot.report(index + 2, logger)
    end
  end
end