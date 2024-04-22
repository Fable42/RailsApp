class SearchController < ApplicationController
  def index 
    @results = post_search

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("posts", partial: "posts/post", collection: @results, as: :post)
      end
    end
  end

  private

  def post_search
    if params[:query].blank?
      @page = params[:page] || 1 
      @posts = Post.order(created_at: :desc).page(@page)
    else
      Post.search(params[:query], fields: %i[body], operator: "or", match: :text_middle)
    end
  end
end