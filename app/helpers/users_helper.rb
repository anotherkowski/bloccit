module UsersHelper
  def has_posts?(user)
    @user.posts.empty?
  end

  def has_comments?(user)
    @user.comments.empty?
  end

  def has_favorites?(user)
    @user.favorites.empty?
end
