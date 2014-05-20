# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    sender nil
    receiver nil
    amount "9.99"
  end
end
