require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "New Question Title", body: "New Question Body")}

  describe "attributes" do
    it "has title and body attributes" do
      expect(question).to have_attributes(title: "New Question Title", body: "New Question Body")
    end
  end
end
