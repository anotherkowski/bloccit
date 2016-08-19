require 'rails_helper'

feature 'favorited posts showing up on user profile' do
  context 'user has favorited some posts' do
    let(:user) { create(:user) }
    let(:posts) { 5.times.map{ create(:post) } }
    before { posts.each {|post| create(:favorite, user: user, post: post)} }

    scenario 'they show up' do
      visit("/users/#{user.id}")
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end
    scenario 'includes OP author gravatars' do
      visit("/users/#{user.id}")
      posts.each do |post|
        expect(page).to have_css("img[src*='#{post.user.avatar_url(35)}']")
      end
    end
    scenario 'includes vote count' do
      visit("/users/#{user.id}")
      posts.each do |post|
        expect(page).to have_content(post.votes.count)
      end
    end
  end
  context 'unfavorited posts do not show up on user profile' do
    let(:user) { create(:user) }
    let(:unfavorite_post) { create(:post) }

    scenario 'they do not show up' do
      visit("/users/#{user.id}")
      expect(page).not_to have_content(unfavorite_post.title)
    end
  end
end
