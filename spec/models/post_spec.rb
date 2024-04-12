require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:views).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(300) }
  end

  it 'belongs to a user' do
    post = Post.new(user: user)
    expect(post.user).to eq(user)
  end

  it 'validates presence of images' do
    post = Post.new(body: "Test body")
    expect(post.valid?).to be_falsey
    expect(post.errors[:images]).to include('Must be at least one video or image')
  end

  it 'validates file type of images' do
    post = create(:post)
    expect(post.valid?).to be_truthy
  end  
  
  it 'calculates like rate correctly' do
    post = create(:post, user: user, unique_views_count: 100, likes_count: 50)
    post.calculate_like_rate
    expect(post.like_rate).to eq(50.0)
  end
end
