require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  # Attributes for parent topic
  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:topic) {Topic.create!(name: name, description: description)}
  # Attributes for sponsored post
  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  let(:price) {rand(100)}
  let(:sponsoredpost) {topic.sponsoredposts.create!(title: title, body: body, price: price)}
  # Expect test sponsored post to have a parent topic
  it {is_expected.to belong_to(:topic)}

  describe "attributes" do
    it "has title, description, price attributes" do
      expect(sponsoredpost).to have_attributes(title: title, body: body, price: price)
    end
  end
end
