require 'spec_helper'

describe Node do
  it 'should auto generate name if name is nil' do
    node = FactoryGirl.create(:node, name: nil)
    node.name.should == "node-#{node.id}"
  end
end
