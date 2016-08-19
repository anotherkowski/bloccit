require 'rails_helper'

feature 'favorited posts showing up on user profile' do
  context 'user has favorited some posts' do
    let(:user) { create(:user) }
    let(:posts) { 5.times.map{ create(:post) } }
    before { posts.each {|post| create(:favorite, user: user, post: post)} }
    scenario 'they show up that' do
      visit("/users/#{user.id}")
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end
  end
end
