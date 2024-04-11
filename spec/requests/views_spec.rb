require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers # for method travel_to

RSpec.describe ViewsController, type: :controller do
  let(:user) { create(:user) }
  let(:post_subject) { create(:post) }

  before { sign_in user }

  describe 'POST #create' do
    context 'users first view' do
      it 'creates a new view and increments unique_views_count' do
        expect {
          post :create, params: { post_id: post_subject.id }
        }.to change(View, :count).by(1)
        .and change { post_subject.reload.unique_views_count }.by(1)
      end
    end

    context 'users second or more view' do
      it 'creates view but not increments unique_views_count' do
        view = create(:view, user: user, post: post_subject)

        travel_to 7.hours.from_now

        expect {
          post :create, params: { post_id: post_subject.id }
        }.to change(View, :count).by(1)
        .and change { post_subject.reload.unique_views_count }.by(0)
      end
    end
  end
end
