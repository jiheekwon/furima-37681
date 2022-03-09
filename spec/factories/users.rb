FactoryBot.define do
  factory :user do

    transient do
      person { Gimei.name }
    end

    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    last_name {person.last}
    first_name {person.first}
    last_name_kana {person.last.katakana}
    first_name_kana {person.first.katakana}
    birth {Faker::Date.backward}
  end
end