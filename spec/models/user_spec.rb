require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password")}

  it {is_expected.to have_many(:posts)}
  it {is_expected.to have_many(:comments)}
  it {is_expected.to have_many(:votes)}
  it {is_expected.to have_many(:favorites)}
  # Shoulda tests for name
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_length_of(:name).is_at_least(1)}
  # Shoulda tests for email
  it {is_expected.to validate_presence_of(:email)}
  it {is_expected.to validate_uniqueness_of(:email)}
  it {is_expected.to validate_length_of(:email).is_at_least(3)}
  it {is_expected.to allow_value("user@bloccit.com").for(:email)}
  # Shoulda tests for password
  it {is_expected.to validate_presence_of(:password)}
  it {is_expected.to have_secure_password}
  it {is_expected.to validate_length_of(:password).is_at_least(6)}


  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
    end
    # expect that users will respond to role
    it "respond to role" do
      expect(user).to respond_to(:role)
    end
    # returns whether or not the user is an admin
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
    # returns whether or not the user is a member
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    # expect that users are assigned the role of member by default
    it "is member by default" do
      expect(user.role).to eq("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end
      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) {User.new(name: "", email: "user@bloccit.com")}
    let(:user_with_invalid_email) {User.new(name: "Bloccit User", email: "")}

    it "should be invalid due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end
    it "should be invalid due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "#favorite_for(post)" do
    let(:other_user) {User.create!(name: "Other Bloccit User", email: "other_user@bloccit.com", password: "password")}
    let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
    let(:my_post) {my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)}

    it "returns `nil` if the user has not favorited the post" do
      expect(other_user.favorite_for(my_post)).to be_nil
    end
    it "returns the appropriate favorite if it exists" do
      my_post
      favorite = user.favorites.first
      expect(user.favorite_for(my_post)).to eq(favorite)
    end
  end
end
