module Neo4jRelation
  extend ActiveSupport::Concern

  included do

  end

  module ClassMethods
    def has_n(model, options = {})
      single_model = model.to_s.singularize
      klass = Object.const_get single_model.capitalize
      define_method "build_#{single_model}" do
        with_check_persisted { klass.new job_id: self.id }
      end
      define_method "create_#{single_model}" do
        with_check_persisted { klass.create job_id: self.id }
      end
      define_method "create_#{single_model}!" do
        with_check_persisted { klass.create! job_id: self.id }
      end
      define_method "#{model}" do
        klass.all job_id: self.id
      end
    end
  end

  protected
  def with_check_persisted
    raise ActiveRecord::RecordNotSaved, 'You cannot call create unless the parent is saved' unless self.persisted?
    yield if block_given?
  end

end