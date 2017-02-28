require 'rails_helper'

 RSpec.describe Api::V1::TopicsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }

   context "unauthenticated user" do
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end

     it "GET show returns http success" do
       get :show, id: my_topic.id
       expect(response).to have_http_status(:success)
     end
     # 49
     it "PUT update returns http unauthenticated" do
       put :update, id: my_topic.id, topic: {name: "Topic Name", description: "Topic Description"}
       expect(response).to have_http_status(401)
     end

     it "POST create returns http unauthenticated" do
       post :create, topic: {name: "Topic Name", description: "Topic Description"}
       expect(response).to have_http_status(401)
     end

     it "DELETE destroy returns http unauthenticated" do
       delete :destroy, id: my_topic.id
       expect(response).to have_http_status(401)
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
     #49
     it "PUT update returns http forbidden" do
       put :update, id: my_topic.id, topic: {name: "Topic Name", description: "Topic Description"}
       expect(response).to have_http_status(403)
     end

     it "POST create returns http forbidden" do
       post :create, topic: {name: "Topic Name", description: "Topic Description"}
       expect(response).to have_http_status(403)
     end

     it "DELETE destroy returns http forbidden" do
       delete :destroy, id: my_topic.id
       expect(response).to have_http_status(403)
     end
   end
 end
