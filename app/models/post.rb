class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy

  # def Post.write_spam!
  #   Post.all.each_with_index do | post, index |
  #     if index % 5 == 0 then
  #       post.title = "SPAM"
  #       post.save
  #     end
  #   end
  # end
end
