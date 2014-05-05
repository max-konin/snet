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

  def twoway_connect_to(station, weight)
    self.connections.create station, weight: weight
    station.connections.create self, weight: weight
  end

  def connections_to_other(stations)
    stations_ids = stations.is_a?(Array) ? stations.map { |s| s.id } : [stations.id]
    connections_rels.to_a.select { |r| stations_ids.include?(r.start_node.id) || stations_ids.include?(r.end_node.id) }
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