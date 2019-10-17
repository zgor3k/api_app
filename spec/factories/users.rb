FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    password { SecureRandom.base64(8) }
  end
end
