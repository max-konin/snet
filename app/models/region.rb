class Region < ActiveRecord::Base
  belongs_to :job
  has_many :points, dependent: :destroy
  accepts_nested_attributes_for :points
end
