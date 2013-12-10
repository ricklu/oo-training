require 'spec_helper'

describe 'SmarterParkingBoy' do

  let(:smarter_parking_boy) { SmarterParkingBoy.new }
  let(:parking_lot_with_6_free_lots) { ParkingLot.new('parking_lot_1', 6) }
  let(:parking_lot_with_5_free_lots) { ParkingLot.new('parking_lot_2', 5) }
  let(:another_parking_lot_with_5_free_lots) { ParkingLot.new('parking_lot_3', 5) }
  let(:parking_lot_with_0_free_lots) { ParkingLot.new('parking_lot_4', 0) }
  let(:car) { Car.new(1) }
  let(:another_car) { Car.new(2) }

  describe 'park car' do

    it 'should park car to the parking lot with least use rate' do
      smarter_parking_boy.add_parking_lot(parking_lot_with_6_free_lots)
      smarter_parking_boy.add_parking_lot(parking_lot_with_5_free_lots)

      parking_lot_with_6_free_lots.park(car)

      parking_card = smarter_parking_boy.park(another_car)
      expect(parking_card.parking_lot_id).to eq(parking_lot_with_5_free_lots.id)
    end

    it 'should parking car to the first parking lot if two parking lot has same use rate' do
      smarter_parking_boy.add_parking_lot(parking_lot_with_5_free_lots)
      smarter_parking_boy.add_parking_lot(another_parking_lot_with_5_free_lots)

      parking_card = smarter_parking_boy.park(car)
      expect(parking_card.parking_lot_id).to eq(parking_lot_with_5_free_lots.id)
    end

    it 'should park car failed if no free lot' do
      smarter_parking_boy.add_parking_lot(parking_lot_with_0_free_lots)
      parking_card = smarter_parking_boy.park(car)
      expect(parking_card).to be_nil
    end
  end

  describe 'pickup car' do
    it 'should pickup successfully with correct stub' do
      parking_card = smarter_parking_boy.park(car)
      mycar = smarter_parking_boy.pickup(parking_card)

      expect(mycar).to eq(car)
      expect(smarter_parking_boy.free_lots).to eq(6)
    end

    it 'should pickup failed with incorrect stub, return nil' do
      invalid_parking_card = ParkingCard.new('invalid_parking_lot', 'invalid_parking_card')

      expect(smarter_parking_boy.pickup(invalid_parking_card)).to be_nil
      expect(smarter_parking_boy.free_lots).to eq(6)
    end

    it 'should pickup failed when pick up the same car twice, return nil' do
      parking_card = smarter_parking_boy.park(car)
      smarter_parking_boy.pickup(parking_card)
      mycar = smarter_parking_boy.pickup(parking_card)

      expect(mycar).to be_nil
      expect(smarter_parking_boy.free_lots).to eq(6)
    end

    before do
      smarter_parking_boy.add_parking_lot(parking_lot_with_6_free_lots)
    end
  end
end