module Metrics
  def self.dist(x, y)
    Math::sqrt (x.latitude - y.latitude) ** 2 + (x.longitude - y.longitude) ** 2
  end
end