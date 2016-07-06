require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:new_user_attributes) do
    {
      name: "Blochead",
      email: "blochead@bloc.io",
      password: "blochead",
      password_confirmation: "blochead",
      avatar_url: "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
    }
  end

  describe "GET new" do
    it "returns HTTP success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

  describe "POST create" do
    it "returns an http redirect" do
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end
    it "creates a new user" do
      expect{post :create, user: new_user_attributes}.to change(User, :count).by(1)
    end
    it "sets user name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).name).to eq new_user_attributes[:name]
    end
    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end
    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end
    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end
     it "logs the user in after sign up" do
       post :create, user: new_user_attributes
       expect(session[:user_id]).to eq assigns(:user).id
     end
     it "retrieves the user gravatar image properly" do
       post :create, user: new_user_attributes
       expect(assigns(:user).avatar_url).to eq new_user_attributes[:avatar_url]
     end
  end
end
