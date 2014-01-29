require 'spec_helper'

describe Region do
  it 'calculate center for square' do
    region = Region.new
    region.points.build(latitude: 0, longitude: 0)
    region.points.build(latitude: 2, longitude: 2)
    region.points.build(latitude: 0, longitude: 2)
    region.points.build(latitude: 2, longitude: 0)
    region.save

    center = region.center
    center.latitude.should eq(1)
    center.longitude.should eq(1)
  end
end
