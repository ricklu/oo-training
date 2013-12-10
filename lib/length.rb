class Length
  attr_accessor :value
  attr_accessor :unit

  UnitConvertRate = {
      'CM' => { 'CM' => 1, 'M' => 0.01},
      'M' => { 'CM' => 100, 'M' => 1 }
  }

  def initialize(value, unit)
    @value = value
    @unit = unit
  end

  def ==(length)
    length_with_same_unit = length.convert(@unit)
    @value == length_with_same_unit.value
  end

  def <(length)
    length_with_same_unit = length.convert(@unit)
    @value < length_with_same_unit.value
  end

  def >(length)
    length_with_same_unit = length.convert(@unit)
    @value > length_with_same_unit.value
  end

  def convert(unit)
    Length.new(@value * get_rate(@unit, unit), unit)
  end

  def convert!(unit)
    @value *= get_rate(@unit, unit)
    @unit = unit
  end

  private
  def get_rate(src_unit, des_unit)
    UnitConvertRate[src_unit][des_unit]
  end
end