# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :station do
    name "MTS"
    capacity 1000
    job_id { (FactoryGirl.create :job).id }
    longitude 100
    latitude 200
  end
end
