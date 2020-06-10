FactoryBot.define do
  factory :user do
    name { generate(:name) }
    email { generate(:email) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end