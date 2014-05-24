require_relative 'helpers/spec_helper'

FakeObject = Struct.new(:name, :color, :pet)

class FakeObjects < Diablo3::Container
  contains FakeObject
  find_by :name
  find_many_by :color, :pet
end

describe Diablo3::Container do
  it 'accepts new items' do
    fo = FakeObjects.new
    expect {
      fo.add(FakeObject.new('mike', :blue, :dog))
      fo.add(FakeObject.new('sarah', :red, :dog))
      fo.add(FakeObject.new('adam', :blue, :cat))
    }.not_to raise_error
  end

  it 'rejects objects that violate the class' do
    fo = FakeObjects.new
    expect {
      fo.add(Struct.new(:stuff))
    }.to raise_error(TypeError, /is not a FakeObject/)
  end

  it 'rejects objects that violate a singular constraint' do
    fo = FakeObjects.new
    expect {
      fo.add(FakeObject.new('mike', :blue, :dog))
      fo.add(FakeObject.new('mike', :red, :dog))
    }.to raise_error(ArgumentError, /name mike already in container/)
  end

  describe '.find_many_by' do
    it 'responds to all_by with all objects that match' do
      fo = FakeObjects.new
      fo.add(FakeObject.new('mike', :blue, :dog))
      fo.add(FakeObject.new('bill', :red, :dog))

      dog_lovers = fo.all_by_pet(:dog)
      red_lovers = fo.all_by_color(:red)

      expect(dog_lovers.size).to eq(2)
      expect(red_lovers.size).to eq(1)

      expect(dog_lovers.map(&:name)).to eq(%w(mike bill))
      expect(red_lovers.map(&:name)).to eq(%w(bill))
    end

    it 'responds to first_by with the earliest object that matches' do
      fo = FakeObjects.new
      fo.add(FakeObject.new('mike', :blue, :dog))
      fo.add(FakeObject.new('bill', :red, :dog))

      result = fo.first_by_pet(:dog)
      expect(result).to be_a(FakeObject)
      expect(result.name).to eq('mike')
    end
  end

  describe '.find_by' do
    it 'returns the object that matches' do
      fo = FakeObjects.new
      fo.add(FakeObject.new('mike', :blue, :dog))
      fo.add(FakeObject.new('bill', :red, :dog))

      result = fo.by_name('mike')
      expect(result).to be_a(FakeObject)
      expect(result.name).to eq('mike')
    end
  end
end
