FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    explain { Faker::Lorem.sentence }
    category_id { 2 }
    condition_id { 2 }
    burden_id { 2 }
    prefecture_id { 2 }
    shipping_date_id { 2 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
