require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsoredpost) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)) }

  describe "GET show" do
    it "returns HTTP success" do
      get :show, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to render_template :show
    end
    it "assigns my_sponsoredpost to @sponsored_post" do
      get :show, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(assigns(:sponsored_post)).to eq(my_sponsoredpost)
    end
  end

  # describe "GET new" do
  #   it "returns http success" do
  #     get :new, topic_id: my_topic.id
  #     expect(response).to have_http_status(:success)
  #   end
  #   it "renders the new view" do
  #     get :new, topic_id: my_topic.id
  #     expect(response).to render_template :new
  #   end
  #   it "instantiates @sponsored_post" do
  #     get :new, topic_id: my_topic.id
  #     expect(assigns(:sponsored_post)).not_to be_nil
  #   end
  # end

end
