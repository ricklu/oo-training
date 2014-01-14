require 'spec_helper'

describe 'Reporter' do
  context 'report' do
    let(:parking_manager) { ParkingBoy.new(NormalChooser.new) }
    let(:another_parking_manager) { ParkingBoy.new(NormalChooser.new) }

    let(:parking_boy) { ParkingBoy.new(NormalChooser.new) }

    let(:first_parking_lot) { ParkingLot.new('parking_lot_1', 10) }
    let(:second_parking_lot) { ParkingLot.new('parking_lot_2', 10) }
    let(:third_parking_lot) { ParkingLot.new('parking_lot_3', 10) }

    let(:first_car) { Car.new('Car 1') }
    let(:second_car) { Car.new('Car 2') }
    let(:third_car) { Car.new('Car 3') }
    let(:fourth_car) { Car.new('Car 4') }
    let(:fifth_car) { Car.new('Car 5') }
    let(:sixth_car) { Car.new('Car 6') }

    describe 'report' do
      it 'should report parked cars' do
        Reporter.report(0, [parking_boy, another_parking_manager], parking_manager.parking_lots)
      end

      before do
        parking_boy.add_parking_lot(first_parking_lot)
        parking_boy.park(third_car)
        parking_boy.park(fourth_car)

        another_parking_manager.add_parking_lot(second_parking_lot)
        another_parking_manager.park(first_car)
        another_parking_manager.park(second_car)
        parking_manager.manage(another_parking_manager)

        parking_manager.manage(parking_boy)

        parking_manager.add_parking_lot(third_parking_lot)
        parking_manager.park(fifth_car)
        parking_manager.park(sixth_car)
      end
    end
  end
end