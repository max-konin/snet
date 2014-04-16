module Coordinates
  extend ActiveSupport::Concern

  included do
    property :latitude,  type: Float
    property :longitude, type: Float
  end

end