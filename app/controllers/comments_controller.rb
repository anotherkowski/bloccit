class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    # @commentable = set_comment
    @comment = @commentable.comments.build(comment_params)
    # if @comment.save
    #   redirect_to [:create]
    # end
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

  def find_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def set_comment
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
