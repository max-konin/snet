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
      graph.edges << edge
      graph
    end

    def create_complete_graph(nodes_count)
      graph = Graph.new
      nodes_count.times { graph.nodes << Node.new }
      graph.nodes.each_with_index do |node, i|
        (nodes_count - i - 1).times do |j|
          graph.edges << Edge.new(nodes: [graph.nodes[i], graph.nodes[i + j + 1]], weight: (i * 100), name: i)
        end
      end
      graph
    end
    
    example 'mst for simple graph' do
      graph = create_simple_graph
      mst = graph.get_mst
      mst.should_not be(nil)
      mst.edges.should_not include(graph.edges.select { |e| e.weight == 100})
    end

    example 'mst for complete_graph' do
      graph = create_complete_graph 5
      mst = graph.get_mst
      mst.should_not be(nil)
      expected_edges = graph.edges.select { |e| e.name == 0 }
      mst.edges.all.should == expected_edges
    end

  end
end
