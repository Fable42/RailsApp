class ViewsController < ApplicationController
  before_action :set_post

  def view
    last_view = @post.views.where(user: current_user).order(viewed_at: :desc).first
    view = @post.views.new(user: current_user, viewed_at: Time.current)

    if last_view.nil?
      view.save
      @post.increment!(:unique_views_count)
      @post.calculate_like_rate
    elsif  Time.current - last_view.viewed_at > 6.hours
      view.save
    end

    render json: { views_count: @post.views_count.to_s, like_rate: @post.like_rate.to_s }
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end
end
