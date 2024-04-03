class ViewsController < ApplicationController

  def view
    view = View.create(user_id: current_user.id, post_id: params[:id], viewed_at: Time.current)

    render plain: view.post.views_count.to_s
  end
end
