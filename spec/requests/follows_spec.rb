require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:follow) { create(:follow, follower: user, followee: other_user) }

  before { sign_in user }

  describe "POST /follow" do
    before { sign_in other_user }

    it "creates a follow" do
      expect {
        post follow_user_path(user)
      }.to change(Follow, :count).by(1)

      expect(response).to redirect_to(profile_path(user))
    end
  end

  describe "POST /unfollow" do
    it "destroys the follow" do
      expect {
        post unfollow_user_path(other_user)
      }.to change(Follow, :count).by(-1)

      expect(response).to redirect_to(profile_path(other_user))
    end
  end

  describe "POST /pin" do
    it "pins the follow" do
      post pin_user_path(other_user)
      expect(follow.reload.pinned).to be true
    end
  end

  describe "POST /unpin" do
    it "unpins the follow" do
      post unpin_user_path(other_user)
      expect(follow.reload.pinned).to be false
    end
  end
end