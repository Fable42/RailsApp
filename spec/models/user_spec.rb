require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should have_many(:views) }
    it { should have_one_attached(:profile_image) }
    it { should have_many(:followed_users).with_foreign_key(:follower_id).class_name('Follow') }
    it { should have_many(:followees).through(:followed_users) }
    it { should have_many(:following_users).with_foreign_key(:followee_id).class_name('Follow') }
    it { should have_many(:followers).through(:following_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:tag) }
    it { should validate_uniqueness_of(:tag) }
    it { should validate_length_of(:tag).is_at_least(3).is_at_most(20) }
    it { should_not allow_value('tag with spaces').for(:tag) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(25) }
  end
end
