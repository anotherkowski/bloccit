class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  # def Post.write_spam!
  #   Post.all.each_with_index do | post, index |
  #     if index % 5 == 0 then
  #       post.title = "SPAM"
  #       post.save
  #     end
  #   end
  # end
end
