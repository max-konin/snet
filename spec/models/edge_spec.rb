require 'spec_helper'

describe Edge do
  it 'should auto generate name if name is nil' do
    edge = FactoryGirl.create(:edge, name: nil)
    edge.name.should == "edge-#{edge.id}"
  end
end
