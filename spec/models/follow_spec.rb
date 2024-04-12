require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject { create(:follow) }

  describe 'associations' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followee).class_name('User') }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:follower_id).scoped_to(:followee_id) }
    it { should validate_uniqueness_of(:followee_id).scoped_to(:follower_id) }
  end
end