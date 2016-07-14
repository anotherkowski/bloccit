class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    # @comment = @commentable.comments.new(params[:comment]) #based on Rails3
    comment = commentable.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      flash[:notice] = "Successfully created..."
      redirect_to :back
    else
      flash[:alert] = "Comment unsuccessful..."
      redirect_to :back
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
       flash[:notice] = "Comment was deleted successfully."
       redirect_to :back
    else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to :back
    end
  end

  private

  # def commentable_url
  #   if @commentable.commentable_type == "Topic"
  #     djd
  #   else
  #     djl
  #   end
  # end

  def commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable ||= resource.singularize.classify.constantize.find(id)
  end

  def set_comment
    @comment ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
