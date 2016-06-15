require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advert) { Advertisement.create!(title: "New Ad Title", body: "New Ad Body", price: 5) }

  describe "attributes" do
    it "has title, body, price attributes" do
      expect(advert).to have_attributes(title: "New Ad Title", body: "New Ad Body", price: 5)
    end
  end
end
