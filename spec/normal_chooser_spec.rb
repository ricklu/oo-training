require 'spec_helper'

describe 'NormalChooser' do

  let(:normal_chooser) { NormalChooser.new }
  let(:parking_lot_with_6_free_lots) { ParkingLot.new('parking_lot_1', 6) }
  let(:parking_lot_with_5_free_lots) { ParkingLot.new('parking_lot_2', 5) }

  describe 'choose' do
    it 'should choose first parking lot with free lot' do
      parking_lots = {
          parking_lot_with_6_free_lots.id => parking_lot_with_6_free_lots,
          parking_lot_with_5_free_lots.id => parking_lot_with_5_free_lots
      }
      expect(normal_chooser.choose(parking_lots)).to eq(parking_lot_with_6_free_lots)
    end
  end
end