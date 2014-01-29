class Region < ActiveRecord::Base
  belongs_to :job
  has_many :points, dependent: :destroy
  accepts_nested_attributes_for :points

  def center
    lat  = 0
    long = 0
    points.each do |p|
      lat  += p.latitude
      long += p.longitude
    end
    Point.new latitude: (lat / points.count), longitude: (long / points.count)
  end
end
