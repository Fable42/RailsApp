class CommentsController < ApplicationController
  before_action :set_post
  before_action :correct_user, only: %i[ destroy ]

  def create
    @comment = current_user.comments.new(comment_params)
  
    if @comment.save
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
    
    else
      redirect_to request.referer, alert: 'There was an error creating the comment.'
    end
  end
  

  def destroy
    @comment.destroy
  
    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: turbo_stream.update("comment-#{@comment.id}")
      end
    end
  end
  
  

  private 

  def comment_params  
    params.require(:comment).permit(:body, :parent_id).merge(post_id: params[:post_id])
  end

  def set_post
    @post = Post.includes(:user).find(params[:post_id])
  end

  def correct_user
    @comment = Comment.find_by(id: params[:id])
    unless @comment && (current_user == @comment.user || current_user == @comment.post.user)
      redirect_to request.referer, alert: 'No permission'
    end
  end
  
end