# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    sender  { create :user, :with_balance }
    receiver { create :user }
    amount "9.99"
  end
end
