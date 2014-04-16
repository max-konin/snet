# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point, :class => 'Point' do
    latitude 10
    longitude 20
  end
end
