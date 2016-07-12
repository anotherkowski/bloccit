class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  #note: Because comments already depend on posts, they will also be deleted when a topic is deleted.
end
