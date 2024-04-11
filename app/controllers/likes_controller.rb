class LikesController < ApplicationController  
  def create
    @like = current_user.likes.create(like_params)

    respond_to do |format|
      format.turbo_stream do
        streams = []
        locals_hash = { @like.likeable_type.downcase.to_sym => @like.likeable }
        streams << turbo_stream.replace("#{@like.likeable_type.downcase}-likes-#{@like.likeable_id}", partial: "likes/#{@like.likeable_type.downcase}-likes", locals: locals_hash )
          
        if @like.likeable_type == 'Post'
          calc_like_rate
          streams << turbo_stream.replace("post-likerate-#{@like.likeable_id}", partial: "likerates/post-likerate", locals: locals_hash )
        end
        
        render turbo_stream: streams
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.turbo_stream do
        streams = []
        locals_hash = { @like.likeable_type.downcase.to_sym => @like.likeable }
        streams << turbo_stream.replace("#{@like.likeable_type.downcase}-likes-#{@like.likeable_id}", partial: "likes/#{@like.likeable_type.downcase}-likes", locals: locals_hash )
        
        if @like.likeable_type == 'Post'
          calc_like_rate
          streams << turbo_stream.replace("post-likerate-#{@like.likeable_id}", partial: "likerates/post-likerate", locals: locals_hash )
        end
      
        render turbo_stream: streams
      end
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