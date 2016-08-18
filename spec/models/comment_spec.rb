require 'rails_helper'

RSpec.describe Comment, type: :model do
  # use factories
  let(:topic) {create(:topic)}
  let(:user) {create(:user)}
  let(:post) {create(:post)}
  let(:comment) { create(:comment)}

  # test that a comment belongs to both a user and a post
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  # test that the comment's body exists and has a minimum length
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: comment.body)
    end
  end

  describe "after_create" do
    before do
       @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
     end
     it "sends an email to users who have favorited the post" do
       favorite = user.favorites.create(post: post)
       expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))
       @another_comment.save!
     end
     it "does not send emails to users who haven't favorited the post" do
       expect(FavoriteMailer).not_to receive(:new_comment)
       @another_comment.save!
     end
   end

end
