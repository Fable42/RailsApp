class PostsController < ApplicationController

  def create
    Post.create( 
      body: params[:post][:body],
      user_id: params[:post][:user_id]
    )

    redirect_to root_path, notice: 'New post created'
  end

  def update
    @post = Post.find(params[:id])

    @post.update(
      body: params[:post][:body],
      user_id: params[:post][:user_id]
    )

    redirect_to root_path, notice: 'Post edited'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, notice: 'Post deleted'
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end
end