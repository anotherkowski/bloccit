module UsersHelper
  # def favorited_posts_for(user)
  #   user.favorites.map{|favorite| favorite.post}
  # end

  def has_posts?(user)
    user.posts.empty?
  end
  def has_comments?(user)
    user.comments.empty?
  end
end
