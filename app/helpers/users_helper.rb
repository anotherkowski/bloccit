module UsersHelper
  def favorited_posts_for(user)
    user.favorites.map{|favorite| favorite.post}
  end
end
