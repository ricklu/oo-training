require_relative '../lib/parking_boy'

class Reporter
  def self.report(index = 0, managed_parking_boys = [], parking_lots = {})
    puts 'Parking Manager Report:' if index == 0

    print '--' * (index + 1)
    puts 'Parking Manager'
    managed_parking_boys.each do |boy|
      if boy.managed_parking_boys.length > 0
        boy.report(index + 1)
      end
    end

    print '--' * (index + 1)
    puts 'Parking Boy'
    managed_parking_boys.each do |boy|
      if boy.managed_parking_boys.length == 0
        boy.report(index + 1)
      end
    end

    print '--' * (index + 1)
    puts 'Parking Lot:'
    parking_lots.values.each do |parking_lot|
      parking_lot.report(index + 2)
    end
  end
end