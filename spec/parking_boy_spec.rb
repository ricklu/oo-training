require 'spec_helper'

describe 'ParkingBoy' do

  let(:parking_boy) { ParkingBoy.new }
  let(:parking_lot) { ParkingLot.new('parking_lot_1', 1) }
  let(:car) { Car.new(1) }
  let(:another_car) { Car.new(2) }

  describe 'manage parking lot' do
    it 'should add a parking lot' do
      parking_boy.add_parking_lot(parking_lot)

      expect(parking_boy.parking_lots.size).to eq(1)
      expect(parking_boy.parking_lots[parking_lot.id]).to be(parking_lot)
      expect(parking_boy.free_lots).to eq(1)
    end

    it 'should remove a parking lot' do
      parking_boy.add_parking_lot(parking_lot)

      expect(parking_boy.remove_parking_lot(parking_lot)).to be(parking_lot)
      expect(parking_boy.parking_lots.size).to eq(0)
      expect(parking_boy.free_lots).to eq(0)
    end
  end

  describe 'park car' do
    it 'should park success if there are enough free lot, return a stub' do
      parking_boy.add_parking_lot(parking_lot)
      parking_card = ParkingCard.new(parking_lot.id, car.id)

      expect(parking_boy.park(car)).to eq(parking_card)
      expect(parking_boy.free_lots).to eq(0)
    end

    it 'should park failed if no free lot, return nil' do
      parking_boy.add_parking_lot(parking_lot)
      parking_boy.park(car)
      expect(parking_boy.park(another_car)).to be_nil
      expect(parking_boy.free_lots).to eq(0)
    end
  end

  describe 'pickup car' do
    it 'should pickup successfully with correct stub' do
      parking_card = parking_boy.park(car)
      mycar = parking_boy.pickup(parking_card)

      expect(mycar).to eq(car)
      expect(parking_boy.free_lots).to eq(1)
    end

    it 'should pickup failed with incorrect stub, return nil' do
      invalid_parking_card = ParkingCard.new('invalid_parking_lot', 'invalid_parking_card')

      expect(parking_boy.pickup(invalid_parking_card)).to be_nil
      expect(parking_boy.free_lots).to eq(1)
    end

    it 'should pickup failed when pick up the same car twice, return nil' do
      parking_card = parking_boy.park(car)
      parking_boy.pickup(parking_card)
      mycar = parking_boy.pickup(parking_card)

      expect(mycar).to be_nil
      expect(parking_boy.free_lots).to eq(1)
    end

    before do
      parking_boy.add_parking_lot(parking_lot)
    end
  end
end