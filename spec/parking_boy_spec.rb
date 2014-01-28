require 'spec_helper'

describe 'ParkingBoy' do
  context 'parking boy' do
    let(:parking_boy) { ParkingBoy.new(ChooserFactory.chooser('normal')) }
    let(:parking_lot) { ParkingLot.new('parking_lot_1', 1) }
    let(:car) { Car.new(1) }
    let(:another_car) { Car.new(2) }
    let(:parking_manager) { ParkingBoy.new(ChooserFactory.chooser('smart')) }

    before do
      NormalChooser.any_instance.stub(:choose).and_return(parking_lot)
      Reporter.any_instance.stub(:report).and_return('parking boy report')
    end

    describe 'manage parking lot' do
      it 'should add a parking lot' do
        parking_boy.add_parking_lot(parking_lot)

        expect(parking_boy.parking_lots.size).to eq(1)
        expect(parking_boy.parking_lots[parking_lot.id]).to be(parking_lot)
      end

      it 'should remove a parking lot' do
        parking_boy.add_parking_lot(parking_lot)

        expect(parking_boy.remove_parking_lot(parking_lot)).to be(parking_lot)
        expect(parking_boy.parking_lots.size).to eq(0)
      end
    end

    describe 'park car' do
      it 'should park success if there are enough free lot, return a stub' do
        parking_boy.add_parking_lot(parking_lot)
        parking_card = ParkingCard.new(parking_lot.id, car.id)

        expect(parking_boy.park(car)).to eq(parking_card)
      end

      it 'should park failed if no free lot, return nil' do
        parking_boy.add_parking_lot(parking_lot)
        parking_boy.park(car)
        expect(parking_boy.park(another_car)).to be_nil
      end
    end

    describe 'pickup car' do
      it 'should pickup from parking manager successfully with correct stub' do
        parking_manager.manage(parking_boy)
        parking_card = parking_manager.park(car)
        mycar = parking_manager.pickup(parking_card)

        expect(mycar).to eq(car)
      end

      it 'should pickup from parking boy successfully with correct stub' do
        parking_card = parking_boy.park(car)
        mycar = parking_boy.pickup(parking_card)

        expect(mycar).to eq(car)
      end

      it 'should pickup failed with incorrect stub, return nil' do
        invalid_parking_card = ParkingCard.new('invalid_parking_lot', 'invalid_parking_card')

        expect(parking_boy.pickup(invalid_parking_card)).to be_nil
      end

      it 'should pickup failed when pick up the same car twice, return nil' do
        parking_card = parking_boy.park(car)
        parking_boy.pickup(parking_card)
        mycar = parking_boy.pickup(parking_card)

        expect(mycar).to be_nil
      end

      before do
        parking_boy.add_parking_lot(parking_lot)
      end
    end

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

    describe 'report' do
      it 'should report' do
        expect(parking_boy.report).to eq('parking boy report')
      end
    end
  end
end