# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region do
    job_id { (FactoryGirl.create :job).id }
    subscribers_count 200

    ignore do
      points []
    end

    after(:create) do |region, evaluator|
      evaluator.points.each do |p|
        p.save! unless p.persisted?
        region.points << p
      end unless evaluator.points.nil?
    end
  end
end
