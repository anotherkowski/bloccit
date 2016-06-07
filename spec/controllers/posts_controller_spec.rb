require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end

    # it "renders the posts index view" do
    #   get :index
    #   expect(response).to render_template('posts/index')
    # end
  end



  # Browser sends, server receives, HTTP request
  # DELETE /posts/5

  # routes.rb
  # delete '/posts/:id', to: 'posts#destroy'

  # posts_controller.rb
  # params = {id: 5}
  # class PostsController
  #   def destroy

  # describe "DELETE destroy" do
  #   let(:my_post) {Post.create!(title: 'my post', description: 'my post')}
  #   it "returns http redirect to posts index" do
  #     delete(:destroy, {id: my_post.id})
  #     expect(response).to redirect_to(posts_path)
  #   end
  #
  #   it "deletes the specified post" do
  #     delete(:destroy, {id: my_post.id})
  #     expect(Post.where(id: my_post.id)).to be_empty
  #   end
  # end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
