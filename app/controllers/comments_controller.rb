class CommentsController < ApplicationController
  before_action :set_post, only: %i[destroy update edit]

  def create
    @comment = current_user.comments.create(comment_params)

    redirect_to post_path(params[:post_id]), notice: 'Comment created'
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(params[:post_id]), notice: 'Comment deleted'
  end

  def edit
    @comment = @post.comments.find(params[:id])    
  end

  def update
    @comment = @post.comments.find(params[:id])
    @comment.update(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@post), notice: 'Comment has been updated'}
      else 
        format.html { redirect_to post_url(@post), alert: 'Comment was not updated'}
      end
    end
  end

  private 

  def comment_params  
    params.require(:comment).permit(:body, :parent_id).merge(post_id: params[:post_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end