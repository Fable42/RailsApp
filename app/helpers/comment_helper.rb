module CommentHelper
  def nested_margin(comment)
    if comment.parent_id?
      "ml-10"
    else
      ""
    end
  end
end