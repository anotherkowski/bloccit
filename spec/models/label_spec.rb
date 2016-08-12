require 'rails_helper'

RSpec.describe Label, type: :model do
  # use factories
  let(:topic) { create(:topic) }
  let(:post) { create(:post) }

  let(:label1) { create(:label) }
  let(:label2) { create(:label) }

  it { is_expected.to have_many :labelings }
  it { is_expected.to have_many(:topics).through(:labelings) }
  it { is_expected.to have_many(:posts).through(:labelings) }

    describe "labelings" do
      it "allows the same label to be associated with a different topic and post" do
        topic.labels << label2
        post.labels << label2

        topic_label = topic.labels[0]
        post_label = post.labels[0]

        expect(topic_label).to eql(post_label)
      end
    end

    describe ".update_labels" do
      it "takes a comma delimted string and returns an array of Labels"  do
        label_first = label1.name
        label_second = label2.name
        labels_string = "#{label_first}, #{label_second}"
        labels_array =[label1.name, label2.name]
        expect(Label.update_labels(labels_string)).to eq(labels_array)
      end
    end
    describe "debug" do
      it "prints label values from factory" do
        label_first = label1.name
        label_second = label2.name
        expect(label_first).not_to eq(label_second)
      end
    end
end
