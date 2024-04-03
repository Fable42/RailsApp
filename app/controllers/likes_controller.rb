class LikesController < ApplicationController  
  after_action :calc_like_rate

  def create
    @like = current_user.likes.new(like_params)

    if @like.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("post-likes", partial: "likes/post-likes", locals: { post: @like.likeable }) }
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render :new, status: 422
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("post-likes", partial: "likes/post-likes", locals: { post: @like.likeable }) }
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

  def calc_like_rate
    @post = @like.likeable
    @post.calculate_like_rate
  end
end