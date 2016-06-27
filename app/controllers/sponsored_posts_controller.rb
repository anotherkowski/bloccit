class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  # def new
  #   @topic = Topic.find(params[:topic_id])
  #   @sponsored_post = SponsoredPost.new
  # end

  # def edit
  # end

end
