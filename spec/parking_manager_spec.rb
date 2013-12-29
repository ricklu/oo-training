require 'spec_helper'

describe 'ParkingManager' do
  let(:parking_manager) { ParkingManager.new(NormalChooser.new) }
  let(:parking_boy) { ParkingBoy.new(NormalChooser.new) }
  let(:parking_lot) { ParkingLot.new('parking_lot_1', 1) }
  let(:car) { Car.new(1) }
  let(:another_car) { Car.new(2) }

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

  describe 'parking by parking boy' do
    context 'parking car' do
      it 'should park success if there are enough free lot, return a stub' do
        parking_card = ParkingCard.new(parking_lot.id, car.id)

        expect(parking_manager.park_by_boy(car)).to eq(parking_card)
      end

      it 'should park failed if no free lot, return nil' do
        parking_manager.park_by_boy(car)
        expect(parking_manager.park_by_boy(another_car)).to be_nil
      end
    end

    describe 'pickup car' do
      it 'should pickup successfully with correct stub' do
        parking_card = parking_manager.park_by_boy(car)
        mycar = parking_manager.pickup_by_boy(parking_card)

        expect(mycar).to eq(car)
      end

      it 'should pickup failed with incorrect stub, return nil' do
        invalid_parking_card = ParkingCard.new('invalid_parking_lot', 'invalid_parking_card')

        expect(parking_manager.pickup_by_boy(invalid_parking_card)).to be_nil
      end

      it 'should pickup failed when pick up the same car twice, return nil' do
        parking_card = parking_manager.park_by_boy(car)
        parking_manager.pickup_by_boy(parking_card)

        expect(parking_manager.pickup_by_boy(parking_card)).to be_nil
      end
    end
    before do
      parking_boy.add_parking_lot(parking_lot)
      parking_manager.manage(parking_boy)
    end
  end
end