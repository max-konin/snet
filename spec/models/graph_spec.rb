require 'spec_helper'

describe Graph do
  it 'should auto generate name if name is nil' do
    graph = FactoryGirl.create(:graph, name: nil)
    graph.name.should == "graph-#{graph.id}"
  end
end
