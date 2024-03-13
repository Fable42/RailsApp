class CommentsController < ApplicationController
  before_action :correct_user, only: %i[destroy]
  before_action :set_post, only: %i[destroy update]
  before_action :set_comment, only: %i[update]

  def create
    @comment = current_user.comments.create(comment_params)

    redirect_to post_path(params[:post_id]), notice: 'Comment deleted'
  end

  def destroy
    @comment.destroy

    redirect_to post_path(params[:post_id]), notice: 'Comment deleted'
  end

  def update
    @comment = @post.comments.find(params[:id])
    @comment.update(comment_params)

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_url(@post), notice: 'Comment has been updated'}
      else 
        format.html { redirect_to post_url(@post), alert: 'Comment was not updated'}
      end
    end
  end

  private 

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path, alert: 'No permittion' if @comment.nil?
  end

  def comment_params  
    params.permit(:body).merge(post_id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end