require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:public) { true }
  # use factories
  let(:topic) { create(:topic) }

  it { is_expected.to have_many(:posts)}
  it { is_expected.to have_many(:labelings)}
  it {is_expected.to have_many(:labels).through(:labelings)}

  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description, public: public)
    end
    it "is public by default" do
      expect(topic.public).to be(true)
    end
  end

  describe "scopes" do
    before do
      @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
    end

    describe "publicly_viewable" do
      it "returns all public topics" do
        expect(Topic.privately_viewable).to eq([@private_topic])
      end
    end
    describe "privately_viewable" do
      it "returns all private topics" do
        expect(Topic.privately_viewable).to eq([@private_topic])
      end
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = User.new
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end
      it "returns only public topics if user is nil" do
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end
  end
end
