FactoryGirl.define do 
  
  factory :user do
    sequence(:name)       {|n| "username#{n}" }
    sequence(:email)      {|n| "user#{n}@test.com" }
    sequence(:subdomain)  { |n| "user-#{n}-subdomain" }
    password              "123qweasd"
    password_confirmation "123qweasd"
  end

  factory :thanker do
    name                   "thanker name"
    email                  "thanker.name@gmail.com"
    subdomain              "testthanker"
    password               "foobar"
    password_confirmation  "foobar"
  end

  factory :welcomer do 
    name                   "welcomer name"
    email                  "welcomer.name@gmail.com"
    subdomain              "testwelcomer"
    password               "bazquux"
    password_confirmation  "bazquux"
  end
  
end
