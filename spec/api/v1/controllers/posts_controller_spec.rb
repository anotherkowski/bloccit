require 'rails_helper'

  RSpec.describe Api::V1::PostsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }
   let(:my_post) { create(:post, topic: my_topic, user: my_user) }

   context "unauthenticated user" do
     it "PUT update returns http unauthenticated" do
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: "new title", body: "new body"}
      expect(response).to have_http_status(401)
    end

    it "POST create returns http unauthenticated" do
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: "new title", body: "new body"}
      expect(response).to have_http_status(401)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id, post: {title: "new title", body: "new body"}
      expect(response).to have_http_status(401)
    end
   end

   context "unauthorized user" do

   end
end
