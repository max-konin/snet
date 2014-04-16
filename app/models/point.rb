class Point 
  include Neo4j::ActiveNode
  include Coordinates

  has_one :consist_in
end