<form action='/posts?utm=something'>
  <input name='post[title]'>
  <input name='post[body]'>
</form>

title: asdf
body: blahblahblh



POST /posts?utm=something

post[title]=asdf+post[body]=blahblahbh



routes.rb
  post '/posts', to: 'posts#create'

# params = {utm: 'something', post: {title: 'asdf', body: 'blahlbhalbhl'}}
class PostsController
  def create
    post = Post.new
    post.title = params[:post][:title]
    post.body = params[:post][:body]
    post.save
    redirect_to "/posts/#{post.id}"
    redirect_to post_path(post.id)
    redirect_to post_path(post)
    redirect_to post
    redirect_to {action: :show, id: post.id}

301 Found
Location: /posts/7


-----


GET /posts/7


routes.rb
  get '/posts/:id', to: 'posts#show'


# params = {id: 7}
class PostsController
  def show
    @post = Post.find(params[:id])
  end
end



200 OK

<html><h1>asdf</h1></html>
