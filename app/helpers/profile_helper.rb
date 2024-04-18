module ProfileHelper
  def user_action_link(current_user, user, css_class: '')
    if current_user.id == user.id
      link_to 'Edit profile', edit_user_registration_path, class: css_class
    else
      if current_user.followees.include?(user)
        button_to "Unfollow", unfollow_user_path, method: :post, class: css_class
      else
        button_to "Follow", follow_user_path, method: :post, class: css_class
      end
    end
  end

  def display_posts(posts, css_class: '')
    posts.map do |post|
      link_to (image_tag(post.images.first, class: css_class)), post_path(post)
    end.join.html_safe
  end

  def user_profile_image(user, css_class: '')
    if user.profile_image.attached?
      image_tag(user.profile_image, class: css_class)
    end
  end
end