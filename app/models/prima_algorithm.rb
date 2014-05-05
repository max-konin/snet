class PrimaAlgorithm

  def initialize(nodes)
    @nodes = []
    nodes.each { |n| @nodes << Node.new(n) }
    @added_nodes = []
    @rels = []
  end

  def do!
    @added_nodes << @nodes.pop
    until @nodes.empty?
      recalculate_weight
      min = @nodes.min_by { |n| n.weight }
      @added_nodes << @nodes.delete(min)
      @rels << {start: min.rel.start_node, end: min.rel.end_node, weight: min.weight}
    end
    rebuild_rels
    @added_nodes
  end

  def self.do!(nodes)
    raise StandardError::ArgumentError.new('nodes must be an array') unless nodes.is_a? Array
    alg = PrimaAlgorithm.new nodes
    alg.do!
  end

  private
  class Node
    attr_accessor :entity, :rel
    def initialize(entity)
      self.entity = entity
    end

    def weight
      rel.nil? ? Float::INFINITY : rel[:weight]
    end

    def id; entity.id end
  end

  def recalculate_weight
    @nodes.each do |n|
      n.rel = n.entity.connections_to_other(@added_nodes).min_by { |r| r[:weight] }
    end
  end

  def rebuild_rels
    @added_nodes.each do |n|
      n.entity.connections_rels.each { |r| r.del }
    end
    @rels.each do |r|
      r[:start].twoway_connect_to r[:end], r[:weight]
    end
  end


end