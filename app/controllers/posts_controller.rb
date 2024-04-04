class PostsController < ApplicationController
  before_action :correct_user, only: %i[ edit update destroy ]
  before_action :set_post, only: %i[ show edit update destroy ]

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to root_path, notice: 'New post created'
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new, status: 422
    end
  end

  def edit
  end

  def show
  end

  def update
    @post.update(post_params)

    redirect_to root_path, notice: 'Post edited'
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: 'Post deleted'
  end

  def index
    @page = params[:page] || 1 
    @posts = Post.order(created_at: :desc).page @page
  end

  private

  def post_params
    if action_name == 'update' && params[:post][:images].first.empty?
      params[:post].delete(:images)
    end
    
    params.require(:post).permit(:body, :user_id, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    @posts = current_user.posts.find_by(id: params[:id])
    redirect_to root_path, alert: 'No permittion' if @posts.nil?
  end
end