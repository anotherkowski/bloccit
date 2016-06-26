class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  #note: Because comments already depend on posts, they will also be deleted when a topic is deleted.
  has_many :sponsored_posts
end
