class Point 
  include Neo4j::ActiveNode
  property :latitude,  type: Float
  property :longitude, type: Float

  has_one :consist_in
end