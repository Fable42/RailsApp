class MainPagesController < ApplicationController
  def index
    @posts = Post.all
  end
end