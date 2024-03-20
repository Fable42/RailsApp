module MainPageHelper
  def sorted_followees
    pinned_followees = current_user.followees.includes(:posts).select { |followee| Follow.find_by(follower: current_user, followee: followee)&.pinned }
    not_pinned_followees = current_user.followees.includes(:posts) - pinned_followees
  
    sorted_pinned_followees = pinned_followees.sort_by { |followee| -(followee.posts.maximum(:created_at).to_i || Time.at(0).to_i) }
    sorted_not_pinned_followees = not_pinned_followees.sort_by { |followee| -(followee.posts.maximum(:created_at).to_i || Time.at(0).to_i) }
  
    sorted_pinned_followees + sorted_not_pinned_followees
  end  
end