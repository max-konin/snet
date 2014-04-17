class Job < ActiveRecord::Base
  belongs_to :user
  include Neo4jRelation

  has_n :regions
  has_n :stations

  before_destroy :destroy_regions
  before_destroy :destroy_stations

  protected

  def destroy_regions
    regions.each {|r| r.destroy }
  end

  def destroy_stations
    stations.each {|s| s.destroy }
  end
end
