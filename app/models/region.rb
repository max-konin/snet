class Region < ActiveRecord::Base
  belongs_to :job
  has_many :points, dependent: :destroy
  accepts_nested_attributes_for :points

  def center
    lat  = 0
    long = 0
    unique_points = points.select('latitude, longitude').uniq
    unique_points.each do |p|
      lat  += p.latitude
      long += p.longitude
    end
    Point.new latitude: (lat / unique_points.length), longitude: (long / unique_points.length)
  end
end
