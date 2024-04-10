require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:post_subject) { create(:post, user: user) }

  before { sign_in user }

  describe 'GET /new' do
    it 'returns http success' do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post posts_path, params: { post: attributes_for(:post) }
        }.to change { Post.count }.by(1)
      end      

      it 'redirects to the root path' do
        post posts_path, params: { post: attributes_for(:post) }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new post' do
        expect {
          post posts_path, params: { post: attributes_for(:post, body: nil) }
        }.not_to change(Post, :count)
      end

      it 're-renders the new method' do
        post posts_path, params: { post: attributes_for(:post, body: nil) }
        expect(response).to render_template :new #needed gem 'rails-controller-testing' to use method 'render_template'
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_post_path(post_subject)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get post_path(post_subject)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      it 'updates the post' do
        patch post_path(post_subject), params: { post: attributes_for(:post, body: 'New Body') }
        post_subject.reload
        expect(post_subject.body).to eq('New Body')
      end

      it 'redirects to the root path' do
        patch post_path(post_subject), params: { post: attributes_for(:post) }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not update the post' do
        patch post_path(post_subject), params: { post: attributes_for(:post, body: nil) }
        post_subject.reload
        expect(post_subject.body).not_to be_nil
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the post' do
      delete post_path(post_subject)
      expect {
        post_subject.reload
      }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'redirects to root_path' do
      delete post_path(post_subject)
      expect(response).to redirect_to root_path
    end
  end
end
