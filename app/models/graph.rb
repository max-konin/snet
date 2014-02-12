class Graph < ActiveRecord::Base
  include AutoGenerateName
  include PrimaAlgorithm

  has_and_belongs_to_many :nodes
  has_and_belongs_to_many :edges
end
