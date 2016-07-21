# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'
# Create users
5.times do
  User.create!(
  name: RandomData.random_name,
  email: RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

# Create Topics
15.times do
  Topic.create!(
  name: RandomData.random_sentence,
  description: RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do
  post = Post.create!(
   # Adding a ! instructs the method to raise an error if there's a problem with the data we're seeding.
  user: users.sample,
  topic: topics.sample,
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph
  )
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

# Create Comments
100.times do # we call times on an Integer (a number object). This will run a given block the specified number of times, which is 100 in this case. The end result of calling times is similar to that of a loop, but in this use-case it is easier to read
  Comment.create!(
  user: users.sample,
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

# Create an admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a member
member = User.create!(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
