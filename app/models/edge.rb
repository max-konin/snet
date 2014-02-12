class Edge < ActiveRecord::Base
  include AutoGenerateName

  attr_accessor :weight
  belongs_to :data, polymorphic: true
  has_and_belongs_to_many :nodes

  accepts_nested_attributes_for :nodes
end
