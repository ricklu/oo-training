require 'spec_helper'

describe 'SmarterChooser' do

  let(:smarter_chooser) { SmarterChooser.new }
  let(:parking_lot_with_6_free_lots) { ParkingLot.new('parking_lot_1', 6) }
  let(:parking_lot_with_5_free_lots) { ParkingLot.new('parking_lot_2', 5) }
  let(:car) { Car.new(1) }

  describe 'choose' do
    it 'should choose parking lot with less use rate' do
      parking_lot_with_6_free_lots.park(car)
      parking_lots = {
          parking_lot_with_6_free_lots.id => parking_lot_with_6_free_lots,
          parking_lot_with_5_free_lots.id => parking_lot_with_5_free_lots
      }
      expect(smarter_chooser.choose(parking_lots)).to eq(parking_lot_with_5_free_lots)
    end
  end
end