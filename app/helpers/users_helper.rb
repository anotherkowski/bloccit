module UsersHelper
  def no_posts?(user)
    user.posts.count > 0
  end
  def no_posts_message(user)
    "#{user.name} has not submitted any posts yet.}"
  end
  def no_comments?(user)
    user.comments.count > 0
  end
  def no_comments_message(user)
    "#{user.name} has not submitted any comments yet.}"
  end
end
