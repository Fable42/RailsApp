class FollowController < ApplicationController
  def create
  end

  def destroy
  end

  private

  def like_params
    params.require(:follow).permit(:following_id, :follower_id)
  end
end