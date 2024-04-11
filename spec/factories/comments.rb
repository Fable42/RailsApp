FactoryBot.define do
  factory :comment do
    association :user
    association :post

    body { FFaker::Lorem.words(3).join(' ') }
    parent_id { nil }
  end
end
