# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region do
    job_id { (FactoryGirl.create :job).id }
  end
end
