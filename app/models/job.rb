class Job < ActiveRecord::Base
  belongs_to :user

  before_destroy :destroy_regions
  before_destroy :destroy_stations

  def regions
    Region.all job_id: self.id
  end

  def stations
    Station.all job_id: self.id
  end

  def create_region!
    with_check_persisted { Region.create! job_id: self.id }
  end

  def create_station!
    with_check_persisted { Station.create! job_id: self.id }
  end

  def build_region
    with_check_persisted { Region.new job_id: self.id }
  end

  def build_station
    with_check_persisted { Station.new job_id: self.id }
  end

  protected
  def with_check_persisted
    raise ActiveRecord::RecordNotSaved, 'You cannot call create unless the parent is saved' unless self.persisted?
    yield if block_given?
  end

  def destroy_regions
    regions.each {|r| r.destroy }
  end

  def destroy_stations
    stations.each {|s| s.destroy }
  end
end
