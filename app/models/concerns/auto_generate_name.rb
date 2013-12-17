module AutoGenerateName
  extend ActiveSupport::Concern

  included do
    after_save ->{update_attributes! name: "#{self.class.to_s.downcase}-#{self.id.to_s}" if name.blank?}
  end

end