FactoryBot.define do
  factory :user do
    name { 'John' }
    surname { 'Doe' }
    patronymic { 'Smith' }
    email { Faker::Internet.email }
    gender { 'male' }
    nationality { 'American' }
    country { 'USA' }
    age { 30 }
    full_name { [ surname, name, patronymic ].join(" ") }
  end
end