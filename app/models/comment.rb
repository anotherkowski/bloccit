class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :body, length: { minimum: 5}, presence: true
  validates :user, presence: true
  validates :commentable_id, presence: true
  validates :commetable_type, presence: true
end
