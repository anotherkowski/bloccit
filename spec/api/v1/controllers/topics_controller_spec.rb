require 'rails_helper'

 RSpec.describe Api::V1::TopicsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }
   let(:my_post) { create(:post, topic: my_topic, user: my_user) }

   context "unauthenticated user" do
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
     it "GET show returns http success" do
       get :show, id: my_topic.id
       expect(response).to have_http_status(:success)
     end
     it "GET show returns child posts" do
       get :show, id: my_topic.id
       response_hash = JSON.parse response.body
       expect(response_hash['posts']).to_not be_nil
     end
   end

   context "unauthorized user" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end
     it "GET show returns http success" do
       get :show, id: my_topic.id
       expect(response).to have_http_status(:success)
     end
     it "GET show returns child posts" do
       get :show, id: my_topic.id
       response_hash = JSON.parse response.body
       expect(response_hash['posts']).to_not be_nil
     end
   end
 end
