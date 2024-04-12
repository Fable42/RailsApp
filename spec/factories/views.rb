FactoryBot.define do
  factory :view do
    association :user
    association :post
    viewed_at { Time.current }
  end
end
