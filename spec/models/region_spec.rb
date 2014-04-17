require 'spec_helper'

describe Region do

  describe '#get_nearest' do
    def region(x, y)
      region = Region.create
      region.points << Point.create(latitude: x, longitude: y)
      region
    end
    it 'return nearest region from array' do
      nearest = region(1,2)
      origin = region(1,1)
      expect(origin.get_nearest [region(10,10), region(2,2), nearest]).to eq(nearest)
    end
  end

  describe '#center' do
    it 'calculate center for square' do
      region = Region.create
      region.points << Point.create(latitude: 0, longitude: 0)
      region.points << Point.create(latitude: 2, longitude: 2)
      region.points << Point.create(latitude: 0, longitude: 2)
      region.points << Point.create(latitude: 2, longitude: 0)
      region.points << Point.create(latitude: 0, longitude: 0)
      region.save
      center = region.center
      center.latitude.should eq(1)
      center.longitude.should eq(1)
    end
  end


end
