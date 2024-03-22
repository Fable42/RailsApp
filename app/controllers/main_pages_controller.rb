class MainPagesController < ApplicationController
  def index
    #@posts = Post.all

    @page = params[:page] || 1 
    @posts = Post.page @page
  end
end