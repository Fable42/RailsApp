module PostHelper
  def liked_by(post, current_user)
    users_liked_post = post.likes.map(&:user).uniq

    if users_liked_post.any?
      followed_users = current_user.followees

      followed_users_liked_post = users_liked_post & followed_users

      pinned_users = followed_users_liked_post.select { |user| current_user.followed_users.find_by(followee_id: user.id).pinned }
      not_pinned_users = followed_users_liked_post - pinned_users

      pinned_users.sort_by! { |user| -user.followers.count }
      top_pinned_users = pinned_users.first(3)

      not_pinned_users.sort_by! { |user| -user.followers.count }
      top_not_pinned_users = not_pinned_users.first(3 - top_pinned_users.count)

      remaining_users = users_liked_post - (top_pinned_users + top_not_pinned_users)
      remaining_users.sort_by! { |user| -user.followers.count }
      top_users = remaining_users.first(3 - top_pinned_users.count - top_not_pinned_users.count)

      (top_pinned_users + top_not_pinned_users + top_users).map(&:profile_image)
    end
  end
end

