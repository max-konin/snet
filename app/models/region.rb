class Region
  include Neo4j::ActiveNode
  property :job_id, type: Integer

  has_n(:points).from(Point, :consist_in)

  def center
    lat  = 0
    long = 0
    unique_points = points.to_a.uniq {|p| 1000 * p.latitude + p.longitude }
    unique_points.each do |p|
      lat  += p.latitude
      long += p.longitude
    end
    Point.new latitude: (lat / unique_points.length), longitude: (long / unique_points.length)
  end

end
