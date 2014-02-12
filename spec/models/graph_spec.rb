require 'spec_helper'

describe Graph do
  it 'should auto generate name if name is nil' do
    graph = FactoryGirl.create(:graph, name: nil)
    graph.name.should == "graph-#{graph.id}"
  end

  describe 'PrimaAlgorithm' do
    let :create_simple_graph do
      graph = Graph.new
      4.times { graph.nodes << Node.new }
      3.times do |i|
        edge = Edge.new(nodes: [graph.nodes[i], graph.nodes[i + 1]])
        edge.weight = 1
        graph.edges << edge
      end
      edge = Edge.new(nodes: [graph.nodes[0], graph.nodes[3]])
      edge.weight = 100
      graph
    end
    
    example 'mst for simple graph' do
      graph = create_simple_graph
      mst = graph.get_mst
      mst.should_not be(nil)
      mst.edges.should_not include(graph.edges.select { |e| e.weight == 100})
    end

  end
end
