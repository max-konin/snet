class Node < ActiveRecord::Base
  belongs_to :data, polymorphic: true

  after_save ->{update_attributes! name: "node-#{self.id}" if name.nil?}
end
