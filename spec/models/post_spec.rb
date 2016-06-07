require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body")}

  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end

  # WORK FROM ASSIGNMENT 31 WITH MENTOR 
  # describe ".write_spam!" do
  #   before do
  #     Post.create!(title: 'post 1', body: 'post 1')
  #     Post.create!(title: 'post 2', body: 'post 2')
  #     Post.create!(title: 'post 3', body: 'post 3')
  #     Post.create!(title: 'post 4', body: 'post 4')
  #     Post.create!(title: 'post 5', body: 'post 5')
  #     Post.create!(title: 'post 6', body: 'post 6')
  #   end
  #
  #   it "overwrites the first post's title with 'SPAM'" do
  #     Post.write_spam!
  #     expect(Post.first.title).to eq("SPAM")
  #   end
  #
  #   it "overwrites the sixth post's title with 'SPAM'" do
  #     Post.write_spam!
  #     expect(Post.all[5].title).to eq("SPAM")
  #   end
  #
  #   it "doesn't overwrite other posts' titles" do
  #     original_title = Post.all[1].title
  #     Post.write_spam!
  #     expect(Post.all[1].title).to eq(original_title)
  #   end
  # end
end
