FactoryBot.define do
  factory :post do
    association :user

    body { FFaker::Lorem.words(5).join(' ') }

    images { 
      [Rack::Test::UploadedFile.new('spec/factories/assets/test_image.png', 'image/png')] 
    }
  end
end
