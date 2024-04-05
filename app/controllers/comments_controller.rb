class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = current_user.comments.create(comment_params)
    
    respond_to do |format|

      if request.referer.ends_with? post_path(@post)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("comment_form", partial: "comments/form-new", locals: { post: @post}),
            turbo_stream.append("comments", partial: "comments/comment", locals: { comment: @comment })
          ]
        end
      else
        format.html { redirect_to post_path(@post), notice: "New comment created!" }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("comment-#{@comment.id}") }
    end    
  end

  private 

  def comment_params  
    params.require(:comment).permit(:body, :parent_id).merge(post_id: params[:post_id])
  end

  def set_post
    @post = Post.includes(:user).find(params[:post_id])
  end
end