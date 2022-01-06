FactoryBot.define do
  sequence :title do |n|
    "MyString - #{n}"
  end

  factory :question do
    title
    body { "MyText" }
  end

  trait :invalid do
    title { nil }
  end
end
