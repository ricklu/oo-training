require_relative '../lib/parking_lot'

class ParkingManager < ParkingBoy
  attr_reader :managed_parking_boys, :is_manager

  def initialize(chooser)
    @managed_parking_boys = []
    super(chooser)
    @is_manager = true
  end

  def manage(parking_boy)
    @managed_parking_boys << parking_boy
  end

  def un_manage(parking_boy)
    @managed_parking_boys.delete_if { |boy| boy == parking_boy }
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

  def report(index)
    puts 'Parking Manager Report:' if index == 0
    report_managers(index)
    report_boys(index)
    report_parking_lots(index)
  end

  private
  def report_parking_lots(index)
    if have_cars?
      print '--' * (index + 1)
      puts 'Parking Lot:'
    end
    @parking_lots.values.each do |parking_lot|
      parking_lot.report(index + 2)
    end
  end

  def report_boys(index)
    if managed_boys_have_car?
      print '--' * (index + 1)
      puts 'Parking Boy:'
    end
    @managed_parking_boys.each do |boy|
      boy.report(index + 2) if !boy.is_manager
    end
  end

  def report_managers(index)
    if managed_managers_have_car?
      print '--' * (index + 1)
      puts 'Parking Manager:'
    end
    @managed_parking_boys.each do |boy|
      boy.report(index + 1) if boy.is_manager
    end
  end

  def managed_boys_have_car?
    @managed_parking_boys.each do |boy|
      return true if !boy.is_manager and boy.have_cars?
    end
    return false
  end

  def managed_managers_have_car?
    @managed_parking_boys.each do |boy|
      return true if boy.is_manager and boy.have_cars?
    end
    return false
  end
end