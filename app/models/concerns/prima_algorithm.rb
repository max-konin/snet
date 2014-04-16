# module PrimaAlgorithm
#   extend ActiveSupport::Concern
#
#   #Return minimal spanning tree for this graph. Uses Prima's algorithme
#   def get_mst
#     tree = Graph.new
#     tree.nodes = self.nodes.all
#     added_nodes     = [tree.nodes.first]
#     remaining_nodes = tree.nodes.all.from(1)
#     tree.edges << prima_do(added_nodes, remaining_nodes, true)
#     while !remaining_nodes.empty?
#       tree.edges << prima_do(added_nodes, remaining_nodes)
#     end
#     tree
#   end
#
#   protected
#   def add_path_to_node(node)
#     class << node
#       attr_accessor :path
#     end
#   end
#
#   def prima_do(added_nodes, remaining_nodes, first = false)
#     recalculate_paths added_nodes, remaining_nodes, first
#     min_node = remaining_nodes.min_by { |n| n.path.nil? ? Float::INFINITY : n.path.weight }
#     added_nodes << min_node
#     remaining_nodes.delete min_node
#     min_node.path
#   end
#
#   def recalculate_paths(added_nodes, remaining_nodes, first = false)
#     remaining_nodes.each do |node|
#       edges = []
#       added_nodes.each { |an| edges << find_cheapest_edge_between(node, an) }
#       add_path_to_node node if first
#       node.path = edges.min_by {|e| e.nil? ? Float::INFINITY : e.weight}
#     end
#   end
#
#   def find_cheapest_edge_between(node1, node2)
#     edges = self.edges.all.select { |e| e.nodes.include?(node1) && e.nodes.include?(node2)}
#     if edges.blank?
#       return nil
#     else
#       return edges.min_by {|e| e.weight}
#     end
#   end
#
#
# end