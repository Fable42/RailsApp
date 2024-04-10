FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name  }
    email { FFaker::Internet.unique.safe_email }
    tag { 'Tag1' }
    password { 'passw0rd' }
    password_confirmation { 'passw0rd' }

    profile_image { 
      Rack::Test::UploadedFile.new('spec/factories/assets/test_image.png', 'image/png') 
    }
  end
end