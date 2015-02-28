FactoryGirl.define do

  factory :ticket do
    sequence(:title) { |n| "#{n}#{Faker::Name.name}"}
    sequence(:body) { |n| "#{Faker::Company.bs}-#{n}" }
  end

end