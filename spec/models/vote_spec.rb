require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:vote) { Vote.create!(value: 1, post: post, user: user) }

   it { is_expected.to belong_to(:post) }
   it { is_expected.to belong_to(:user) }

   it { is_expected.to validate_presence_of(:value) }

   it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }

   describe "update_post callback" do
     it "triggers update_post on save" do
       expect(vote).to receive(:update_post).at_least(:once)
       vote.save!
     end
     it "#update_post should call update_rank on post" do
       expect(post).to receive(:update_rank).at_least(:once)
       vote.save!
     end
   end
   describe "uniqueness per user per post" do
     it "is invalid when user has already voted on post" do
       vote
       new_vote = Vote.new(value: 1, post: post, user: user)
       expect(new_vote).to_not be_valid
     end

   end
 end
