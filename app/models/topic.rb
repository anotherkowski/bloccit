class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  #note: Because comments already depend on posts, they will also be deleted when a topic is deleted.

  # checkpoint 35 - validate topic
  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15 }, presence: true
  
end
