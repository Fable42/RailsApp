class LikesController < ApplicationController  
  def create
    @like = current_user.likes.create(like_params)

    redirect_to root_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    likeable = @like.likeable
    @like.destroy

    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end