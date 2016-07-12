class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    id = params[:post_id] || params[:topic_id]

    if params[:post_id]
      @parent = Post.find(id)
    elsif params[:topic_id]
      @parent = Topic.find(id)
    end

    @comment = @parent.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      if @parent.is_a?(Post)
        flash[:notice] = "Successfully created..."
        redirect_to [@parent.topic, @parent]
      elsif @parent.is_a?(Topic)
        flash[:notice] = "Successfully created..."
        redirect_to [@parent]
      end
    else
      flash[:alert] = "Comment failed to save."
      redirect_to :back
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    
     if comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to :back
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to :back
     end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :id)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to :back
    end
  end
end
