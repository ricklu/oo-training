require 'spec_helper'

describe 'ParkingLot' do

  let(:car) { Car.new(1) }
  let(:parking_lot) { ParkingLot.new('parking_lot_1', 10) }

  describe 'park' do
    it 'should park success if there are enough free lot, return a stub' do
      parking_card = ParkingCard.new(parking_lot.id, car.id)
      parking_lot.park(car).should == parking_card
      expect(parking_lot.free_lot).to eq(9)
    end

    it 'should park failed if no free lot, return nil' do
      parking_lot = ParkingLot.new('parking_lot_1', 0)

      expect(parking_lot.park(car)).to be_nil
      expect(parking_lot.free_lot).to eq(0)
    end
  end

  describe 'pickup' do
    it 'should pickup successfully with correct stub' do
      parking_card = parking_lot.park(car)
      mycar = parking_lot.pickup(parking_card)

      expect(mycar).to be(car)
      expect(parking_lot.free_lot).to eq(10)
    end

    it 'should pickup failed with incorrect stub, return nil' do
      invalid_parking_card = ParkingCard.new('invalid_parking_lot', 'invalid_parking_card')
      mycar = parking_lot.pickup(invalid_parking_card)

      expect(mycar).to be_nil
    end

    it 'should pickup failed when pick up the same car twice, return nil' do
      parking_card = parking_lot.park(car)
      parking_lot.pickup(parking_card)
      car = parking_lot.pickup(parking_card)

      expect(car).to be(nil)
      expect(parking_lot.free_lot).to eq(10)
    end
  end
end