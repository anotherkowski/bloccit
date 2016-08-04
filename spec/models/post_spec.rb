require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }

  let(:topic) { Topic.create!(name: name, description:description)}
  let(:user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  let(:post) {topic.posts.create!(title: title, body: body, user: user)}

  it {is_expected.to have_many(:labelings)}
  it {is_expected.to have_many(:labels).through(:labelings)}
  it { is_expected.to have_many(:comments)}
  it { is_expected.to have_many(:votes)}
  it { is_expected.to have_many(:favorites)}

  it { is_expected.to belong_to(:topic)}
  it { is_expected.to belong_to(:user)}

  it { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_presence_of(:body)}
  it { is_expected.to validate_presence_of(:topic)}
  it { is_expected.to validate_presence_of(:user)}

  it { is_expected.to validate_length_of(:title).is_at_least(5)}
  it { is_expected.to validate_length_of(:body).is_at_least(20)}

  describe "attributes" do
    it "has title, body, and user attributes" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end

  describe "voting" do
     before do
       3.times { post.votes.create!(value: 1) }
       2.times { post.votes.create!(value: -1) }
       @up_votes = post.votes.where(value: 1).count
       @down_votes = post.votes.where(value: -1).count
     end
     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( post.up_votes ).to eq(@up_votes)
       end
     end
     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( post.down_votes ).to eq(@down_votes)
       end
     end
     describe "#points" do
       it "returns the sum of all down and up votes" do
         expect( post.points ).to eq(@up_votes - @down_votes)
       end
     end
     describe "#update_rank" do
        it "calculates the correct rank" do
         post.update_rank
         expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
        end
        it "updates the rank when an up vote is created" do
         old_rank = post.rank
         post.votes.create!(value: 1)
         expect(post.rank).to eq(old_rank + 1)
        end
        it "updates the rank when a down vote is created" do
         old_rank = post.rank
         post.votes.create!(value: -1)
         expect(post.rank).to eq(old_rank - 1)
        end
      end
   end
   context "after_create callback" do
     let(:another_user) {User.create!(name: "Ann Novakowski", email: "annhnova@gmail.com", password: "helloworld")}

     let(:another_post) {topic.posts.new(title: "Another post title", body: "another post body with some words and some more words like this", user: another_user)}

     describe "favorite_own_post" do
       it "triggers favorite_own_post after post is saved" do
         expect(another_post).to receive(:favorite_own_post).at_least(:once)
         another_post.save
       end
       #  it "creates new favorite for post by current user" do
       #    # initiate new post
       #    # expect current user has not favorited this post
       #    # save post
       #    # expect that current user now DOES have a favorite for this post
       #  end
       #  it "creates first and unique favorite for post" do
       #    #create post
       #    # expect post to have 1 favorite
       #    # expect first favorite to belong to current user
       #  end
     end
     describe "send_post_emails" do
       it "triggers new_post FavoritesMailer" do
         # create post
         # expect that new_post mailer is triggered
         expect(FavoriteMailer).to receive(:new_post).with(another_user,another_post).and_return(double(deliver_now: true))
         another_post.save
       end
     end
   end
end
