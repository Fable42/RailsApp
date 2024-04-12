require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
    it { should belong_to(:parent).class_name('Comment').optional }
    it { should have_many(:comments).with_foreign_key(:parent_id) }
    it { should have_many(:likes) }
    it { should have_many(:replies).class_name('Comment').with_foreign_key(:parent_id).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(250) }
  end
end