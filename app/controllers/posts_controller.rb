class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: 'New post created'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    @post.update(post_params)

    redirect_to root_path, notice: 'Post edited'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, notice: 'Post deleted'
  end

  def correct_user
    @posts = current_user.posts.find_by(id: params[:id])
    redirect_to root_path, alert: 'No permittion' if @posts.nil?
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id,images: [])
  end
end