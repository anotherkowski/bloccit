require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }

  before do
    create_session(my_user)
  end

  describe "Destroy" do
    describe "for a comment belonging to a post" do
      before { request.env['HTTP_REFERER'] = topic_post_path(my_topic, my_post) }
      let!(:comment) { Comment.create!(body: "a valid comment", commentable: my_post, user: my_user) }

      it "sets the flash thing right" do
        delete(:destroy,{id: comment.id})
        expect(flash[:notice]).to include("deleted successfully")
      end

      it "redirects back to the post's show page" do
        delete(:destroy,{id: comment.id})
        expect(response).to redirect_to [my_topic, my_post]
      end

      it "deletes the comment" do
        original_count = Comment.count
        delete(:destroy,{id: comment.id})
        final_count = Comment.count
        expect(final_count).to eq(original_count - 1)
        # expect {
        #   delete(:destroy,{id: comment.id})
        # }.to change { Comment.count }.by(-1)
      end
    end

    describe "topic" do
      it "works" do

      end
    end
  end
end
