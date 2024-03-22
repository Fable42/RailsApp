module CommentHelper
  def replyed_to(comment)
    if comment.body.length > 10
      truncated_body = comment.body[0..9] + '...'
    else
      truncated_body = comment.body
    end
  end
end