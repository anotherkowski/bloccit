class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
  end

  # def create
  #   @post = Post.find(params[:post_id])
  #   comment = @post.comments.new(comment_params)
  #   comment.user = current_user
  #
  #   if comment.save
  #     flash[:notice] = "Successfully created..."
  #     redirect_to [@post.topic, @post]
  #   else
  #     flash[:alert] = "Comment failed to save."
  #     redirect_to [@post.topic, @post]
  #   end
  # end

  def destroy
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
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
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
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
