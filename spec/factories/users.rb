FactoryGirl.define do
  factory :user do
    username { Forgery(:internet).email_address }
    password { Forgery(:basic).password(at_least: 4) }

    trait :with_balance do
      after(:create) do |record|
        record.account.add(100)
      end
    end
  end
end