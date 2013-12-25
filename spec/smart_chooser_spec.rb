require 'spec_helper'

describe 'SmartChooser' do

  let(:smart_chooser) { SmartChooser.new }
  let(:parking_lot_with_6_free_lots) { ParkingLot.new('parking_lot_1', 6) }
  let(:parking_lot_with_5_free_lots) { ParkingLot.new('parking_lot_2', 5) }

  describe 'choose' do
    it 'should choose parking lot with more free lots' do
      parking_lots = {
          parking_lot_with_6_free_lots.id => parking_lot_with_6_free_lots,
          parking_lot_with_5_free_lots.id => parking_lot_with_5_free_lots
      }
      expect(smart_chooser.choose(parking_lots)).to eq(parking_lot_with_6_free_lots)
    end
  end
end