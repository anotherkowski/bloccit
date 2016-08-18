class UsersController < ApplicationController
  include UsersHelper

  def new
    @user = User.new
  end
  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
  end

  private

  def no_posts?(user)
    @user = User.find(params[:id])
    user.posts.count > 0
  end
  def no_posts_message(user)
    @user = User.find(params[:id])
    "#{user.name} has not submitted any posts yet.}"
  end
  def no_comments?(user)
    @user = User.find(params[:id])
    user.comments.count > 0
  end
  def no_comments_message(user)
    @user = User.find(params[:id])
    "#{user.name} has not submitted any comments yet.}"
  end
end
