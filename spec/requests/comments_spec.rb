require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:post_subject) { create(:post, user: user) }

  let(:other_user) { create(:user) }

  let(:comment) { create(:comment, post: post_subject, user: user) }
  let(:other_comment) { create(:comment, post: post_subject, user: other_user) }

  before { sign_in user }

  describe "POST /create" do
    context "with valid params from main page" do
      it "creates a new Comment and renders turbo stream" do
        post post_comments_path(post_subject.id),
          params: { comment: attributes_for(:comment) },
          headers: { "HTTP_REFERER": post_path(post_subject), "accept": "text/vnd.turbo-stream.html" }

        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(Comment.count).to eq(1)
      end
    end

    context "with valid params from post page" do
      it "creates a new Comment and redirects to post page" do
        post post_comments_path(post_subject.id),
          params: { comment: attributes_for(:comment) },
          headers: { "HTTP_REFERER": root_path }

        expect(response).to redirect_to post_path(post_subject)
        expect(Comment.count).to eq(1)
      end
    end

    context "creates reply" do
      before { sign_in other_user }

      it "by adding parent id" do
        post post_comments_path(post_subject.id),
          params: { comment: attributes_for(:comment, parent_id: comment.id) },
          headers: { "HTTP_REFERER": post_path(post_subject), "accept": "text/vnd.turbo-stream.html" }

        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(Comment.count).to eq(2)
      end
    end

    context "with invalid params" do
      it "does not create a new Comment" do
        post post_comments_path(post_subject.id),
          params: { comment: attributes_for(:comment, body: nil) },
          headers: { "HTTP_REFERER": post_path(post_subject), "accept": "text/vnd.turbo-stream.html" }

        expect(Comment.count).to eq(0)
      end
    end
  end

  describe "DELETE /destroy" do
    context 'when the user is the owner' do
      it "destroys the comment" do
        delete post_comment_path(post_subject.id, comment.id), headers: { "accept": "text/vnd.turbo-stream.html" }
        expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it "destroys the comment and its replies" do
        reply = create(:comment, post: post_subject, user: user, parent_id: comment.id)
        
        expect {
          delete post_comment_path(post_subject.id, comment.id), 
            headers: { "HTTP_REFERER": post_path(post_subject), "accept": "text/vnd.turbo-stream.html" }
        }.to change(Comment, :count).by(-2)
        
        expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
        expect { reply.reload }.to raise_error ActiveRecord::RecordNotFound
      end

    end

    context 'when the user is not the comment or post owner' do
      before { sign_in other_user }

      it "does not destroy the comment" do
        delete post_comment_path(post_subject.id, comment.id),
          headers: { "HTTP_REFERER": post_path(post_subject),
          "accept": "text/vnd.turbo-stream.html" }
          
        expect { comment.reload }.not_to change(Comment, :count)
      end
    end

    context 'when the user is not the comment owner but post owner' do
      it "destroys the comment" do
        delete post_comment_path(post_subject.id, other_comment.id),
          headers: { "HTTP_REFERER": post_path(post_subject), "accept": "text/vnd.turbo-stream.html" }

        expect { other_comment.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end