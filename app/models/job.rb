class Job < ActiveRecord::Base
  has_many :regions, dependent: :destroy
  belongs_to :user
end
