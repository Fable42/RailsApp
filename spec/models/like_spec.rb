require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { create(:like) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:likeable) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to([:likeable_id, :likeable_type]) }
  end
end