require 'spec_helper'

describe 'My behaviour' do
  let(:length1) { Length.new(1, 'M') }
  let(:length2) { Length.new(1, 'M') }
  let(:length3) { Length.new(2, 'M') }
  let(:length4) { Length.new(100, 'CM') }
  let(:length5) { Length.new(200, 'CM') }

  it 'should 1M equals to 1M' do
    expect(length1 == length2).to eq(true)
  end

  it 'should 1M equals to 100CM' do
    expect(length1 == length4).to eq(true)
  end

  it 'should 1M less than 2M' do
    expect(length1 < length3).to eq(true)
  end

  it 'should 100CM less than 2M' do
    expect(length4 < length3).to eq(true)
  end

  it 'should 2M greater than 1M' do
    expect(length3 > length1).to eq(true)
  end

  it 'should 200CM greater than 1M' do
    expect(length5 > length1).to eq(true)
  end

  it 'should convert 1M to 100CM' do
    expect(length1.convert('CM')).to eq(length4)
  end

  it 'should convert 1M to 1M' do
    expect(length1.convert('M')).to eq(length2)
  end

  it 'should convert itself from 1M to 100CM' do
    # should check length1 itself or its value and unit?
    length1.convert!('CM')
    expect(length1.unit).to eq('CM')
    expect(length1.value).to eq(100)
  end
end