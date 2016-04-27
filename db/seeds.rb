# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create Posts
50.times do
  Post.create!( # Adding a ! instructs the method to raise an error if there's a problem with the data we're seeding.
  title: RandomData.random_sentence,
  body: RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
100.times do # we call times on an Integer (a number object). This will run a given block the specified number of times, which is 100 in this case. The end result of calling times is similar to that of a loop, but in this use-case it is easier to read
  Comment.create!(
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
