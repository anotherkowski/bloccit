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

  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    it "renders the new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
    it "instantiates @sponsored_post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of the sponsored posts by 1" do
      expect{post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)}}.to change(SponsoredPost,:count).by(1)
    end
    it "assigns the new sponsored post to @sponsored_post" do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)}
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end
    it "redirects to the new sponsored post" do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_sponsoredpost.id
      expect(response).to render_template :edit
    end
    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_sponsoredpost.id
      post_instance = assigns(:sponsored_post)

      expect(post_instance.id).to eq my_sponsoredpost.id
      expect(post_instance.title).to eq my_sponsoredpost.title
      expect(post_instance.body).to eq my_sponsoredpost.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, topic_id: my_topic.id, id: my_sponsoredpost.id, sponsored_post: {title: new_title, body: new_body}

      updated_post = assigns(:sponsored_post)
      expect(updated_post.id).to eq my_sponsoredpost.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, topic_id: my_topic.id, id: my_sponsoredpost.id, sponsored_post: {title: new_title, body: new_body}
      expect(response).to redirect_to [my_topic, my_sponsoredpost]
    end
  end

end
