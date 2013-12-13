class Node < ActiveRecord::Base
  include AutoGenerateName

  belongs_to :data, polymorphic: true
  has_and_belongs_to_many :edges
end
