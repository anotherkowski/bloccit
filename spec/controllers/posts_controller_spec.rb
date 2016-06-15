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

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of the post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end
    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      expect(assigns(:post)).to eq(my_post)
    end
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

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
