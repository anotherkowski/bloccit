class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  #note: Because comments already depend on posts, they will also be deleted when a topic is deleted.

  scope :visible_to, -> (user) { user ?  all : where(public: true) }
end
