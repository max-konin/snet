class Job < ActiveRecord::Base
  belongs_to :user
  include Neo4jRelation

  has_n :regions
  has_n :stations

  before_destroy :destroy_regions
  before_destroy :destroy_stations

  def dotting_stations!(capacity)
    destroy_stations
    regions = self.regions.each.to_a
    return false if regions.empty?
    last_station = Station.create! capacity: capacity, job_id: self.id
    unless regions.empty?
      nearest_region = get_nearest_region regions, last_station.serves.each.to_a
      last_station = Station.create! capacity: capacity, job_id: self.id unless last_station.can_serves? nearest_region.subscribers_count
      last_station.serves << nearest_region
    end
    stations.each {|s| s.set_optimal_cords!}
  end

  protected

  def get_nearest_region(from_regions, to_regions)
    return from_regions.first if to_regions.empty?
    from_regions.min_by { |x| Metrics.dist x, x.get_nearest(to_regions) }
  end

  def destroy_regions
    regions.each {|r| r.destroy }
  end

  def destroy_stations
    stations.each {|s| s.destroy }
  end
end
