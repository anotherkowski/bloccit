require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  let(:price) {rand(100)}
  let(:sponsoredpost) {SponsoredPost.create!(title: title, body: body, price: price)}
  # let(:topic)
  # let(:sponsoredpost) {Topic.create!()}
  describe "attributes" do
    it "has title, description, price attributes" do
      expect(sponsoredpost).to have_attributes(title: title, body: body, price: price)
    end
  end
end
