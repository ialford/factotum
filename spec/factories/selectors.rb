# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :selector do
    sequence(:netid) { |n| "test#{n}" }
  end
end