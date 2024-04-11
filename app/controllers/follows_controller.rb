class FollowsController < ApplicationController
  before_action :set_user

  def create
    Follow.create(follower: current_user, followee: @user)
    redirect_back(fallback_location: profile_path(@user))
  end
  
  def destroy
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: profile_path(@user))
  end

  def pin
    follow = current_user.followed_users.find_by(followee_id: @user.id)
    follow.update(pinned: true) if follow
    redirect_back(fallback_location: profile_path(@user))
  end

  def unpin
    follow = current_user.followed_users.find_by(followee_id: @user.id)
    follow.update(pinned: false) if follow
    redirect_back(fallback_location: profile_path(@user))
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
