FactoryGirl.define do
  factory :user do
    username { Forgery(:internet).email_address }
    password { Forgery(:basic).password(at_least: 4) }
  end
end