class CommentsController < ApplicationController
  before_action :set_post, only: %i[destroy update edit]

  def create
    @comment = current_user.comments.create(comment_params)

    redirect_to post_path(params[:post_id]), notice: 'Comment created'
  end

  def destroy
    @comment = @post.comments.includes(:user).find(params[:id])
    @comment.destroy

    redirect_to post_path(params[:post_id]), notice: 'Comment deleted'
  end

  private 

  def comment_params  
    params.require(:comment).permit(:body, :parent_id).merge(post_id: params[:post_id])
  end

  def set_post
    @post = Post.includes(:user).find(params[:id])
  end
end