class Node < ActiveRecord::Base
  include AutoGenerateName

  belongs_to :data, polymorphic: true
end
