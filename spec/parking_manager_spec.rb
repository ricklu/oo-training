require 'spec_helper'

describe 'ParkingManager' do
  let(:parking_manager) { ParkingManager.new(NormalChooser.new) }
  let(:another_parking_manager) { ParkingManager.new(NormalChooser.new) }

  let(:parking_boy) { ParkingBoy.new(NormalChooser.new) }

  let(:one_lot_parkint_lot) { ParkingLot.new('parking_lot', 1) }
  let(:first_parking_lot) { ParkingLot.new('parking_lot_1', 10) }
  let(:second_parking_lot) { ParkingLot.new('parking_lot_2', 10) }
  let(:third_parking_lot) { ParkingLot.new('parking_lot_3', 10) }

  let(:first_car) { Car.new('Car 1') }
  let(:second_car) { Car.new('Car 2') }
  let(:third_car) { Car.new('Car 3') }
  let(:fourth_car) { Car.new('Car 4') }
  let(:fifth_car) { Car.new('Car 5') }
  let(:sixth_car) { Car.new('Car 6') }

  describe 'manage parking boy' do
    it 'should add a parking boy' do
      parking_manager.manage(parking_boy)
      expect(parking_manager.managed_parking_boys.size).to eq(1)
      expect(parking_manager.managed_parking_boys[0]).to be(parking_boy)
    end

    it 'should un_manage a parking boy' do
      parking_manager.manage(parking_boy)
      parking_manager.un_manage(parking_boy)
      expect(parking_manager.managed_parking_boys.size).to eq(0)
    end
  end

  describe 'parking/pickup by parking boy' do
    context 'parking car' do
      it 'should park success if there are enough free lot, return a stub' do
        parking_card = ParkingCard.new(first_parking_lot.id, first_car.id)

        expect(parking_manager.park_by_boy(first_car)).to eq(parking_card)
      end

      it 'should park failed if no free lot, return nil' do
        parking_manager.park_by_boy(first_car)
        expect(parking_manager.park_by_boy(second_car)).to be_nil
      end
    end

    describe 'pickup car' do
      it 'should pickup successfully with correct stub' do
        parking_card = parking_manager.park_by_boy(first_car)
        mycar = parking_manager.pickup_by_boy(parking_card)

        expect(mycar).to eq(first_car)
      end

      it 'should pickup failed with incorrect stub, return nil' do
        invalid_parking_card = ParkingCard.new('invalid_parking_lot', 'invalid_parking_card')

        expect(parking_manager.pickup_by_boy(invalid_parking_card)).to be_nil
      end

      it 'should pickup failed when pick up the same car twice, return nil' do
        parking_card = parking_manager.park_by_boy(first_car)
        parking_manager.pickup_by_boy(parking_card)

        expect(parking_manager.pickup_by_boy(parking_card)).to be_nil
      end
    end
    before do
      parking_boy.add_parking_lot(one_lot_parkint_lot)
      parking_manager.manage(parking_boy)
    end
  end

  describe 'report' do
    it 'should report parked cars' do
      parking_manager.report(0)
    end

    before do
      another_parking_manager.add_parking_lot(second_parking_lot)
      another_parking_manager.park(first_car)
      another_parking_manager.park(second_car)
      parking_manager.manage(another_parking_manager)

      parking_boy.add_parking_lot(first_parking_lot)
      parking_boy.park(third_car)
      parking_boy.park(fourth_car)
      parking_manager.manage(parking_boy)

      parking_manager.add_parking_lot(third_parking_lot)
      parking_manager.park(fifth_car)
      parking_manager.park(sixth_car)
    end
  end

end