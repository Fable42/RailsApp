class LikesController < ApplicationController  
  def create
    @like = current_user.likes.create(like_params)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end