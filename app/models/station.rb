class Station
  include Neo4j::ActiveNode
  include Coordinates

  property :name,     type: String
  property :capacity, type: Integer
  property :job_id,   type: Integer

  has_n(:serves).from(Region, :connected_to)

  has_n(:connections)

  def full?
    can_serves? 0
  end

  def can_serves?(subscribers_count)
    sum = subscribers_count
    serves.each { |r| sum += r.subscribers_count}
    sum <= self.capacity
  end

  def set_optimal_cords!
    lat  = 0
    long = 0
    subscribers_count = 0
    serves.each do |r|
      p = r.center
      lat  += p.latitude * r.subscribers_count
      long += p.longitude * r.subscribers_count
      subscribers_count += r.subscribers_count
    end
    self.latitude  = lat / subscribers_count
    self.longitude = long / subscribers_count
    save!
  end
end