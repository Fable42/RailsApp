class UsersController < ApplicationController
  before_action :set_user, only: %i[ follow unfollow ]

  def follow
    Follow.create(follower: current_user, followee: @user)
    redirect_back(fallback_location: profile_path(@user))
  end
  
  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: profile_path(@user))
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
