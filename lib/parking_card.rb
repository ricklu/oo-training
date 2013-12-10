class ParkingCard
  attr_accessor :car_id, :parking_lot_id
  def initialize(parking_lot_id, car_id)
    @parking_lot_id = parking_lot_id
    @car_id = car_id
  end

  def ==(other_card)
    @parking_lot_id == other_card.parking_lot_id
    @car_id == other_card.car_id
  end
end