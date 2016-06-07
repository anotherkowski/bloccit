class Post < ActiveRecord::Base
  has_many :comments

  # def Post.write_spam!
  #   Post.all.each_with_index do | post, index |
  #     if index % 5 == 0 then
  #       post.title = "SPAM"
  #       post.save
  #     end
  #   end
  # end
end
