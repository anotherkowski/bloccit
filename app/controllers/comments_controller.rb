class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Successfully created..."
      redirect_to [@commentable]
    else
      flash[:alert] = "Comment unsuccessful..."
      redirect_to [@commentable]
    end
  end

  def destroy
    @comment = set_comment
    @commentable = @comment.commentable
    if @comment.destroy
       flash[:notice] = "Comment was deleted successfully."
       redirect_to [@commentable]
    else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to [@commentable]
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def set_comment
    Comment.find(params[:id])
  end

  # def comment_params
  #   params.require(:comment).permit(:body, :commentable)
  # end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
