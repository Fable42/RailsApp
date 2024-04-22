class MainPagesController < ApplicationController
  def index
    @page = params[:page] || 1 
    @posts = Post.order(created_at: :desc).page(@page)
  end
end