require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:post_subject) { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, post: post_subject) }

  before { sign_in user }

  describe "POST /create" do
    context "when liking a post" do
      it "creates a like" do
        expect {
          post likes_path, params: { like: { likeable_id: post_subject.id, likeable_type: 'Post' } }, as: :turbo_stream
        }.to change(Like, :count).by(1)
  
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response).to have_http_status(:ok)
      end
    end
  
    context "when liking a comment" do
      it "creates a like" do
        expect {
          post likes_path, params: { like: { likeable_id: comment.id, likeable_type: 'Comment' } }, as: :turbo_stream
        }.to change(Like, :count).by(1)
  
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response).to have_http_status(:ok)
      end
    end

    context "when liking a post twice" do
      it "does not create a second like" do
        like = create(:like, user: user, likeable: post_subject)
        expect {
          post likes_path, params: { like: { likeable_id: post_subject.id, likeable_type: 'Post' } }, as: :turbo_stream
        }.to_not change(Like, :count)
      end
    end
  end  

  describe "DELETE /destroy" do
    it "destroys the like" do
      like = create(:like, user: user, likeable: post_subject)

      expect {
        delete like_path(like), as: :turbo_stream
      }.to change(Like, :count).by(-1)

      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response).to have_http_status(:ok)
    end
  end
end
