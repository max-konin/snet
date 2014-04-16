class Job < ActiveRecord::Base
  belongs_to :user

  def regions
    Region.all job_id: self.id
  end

  def create_region!
    if self.persisted?
      Region.create! job_id: self.id
    else
      raise ActiveRecord::RecordNotSaved, 'You cannot call create unless the parent is saved'
    end
  end
end
