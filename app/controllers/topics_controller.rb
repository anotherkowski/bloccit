class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show, :edit]
  before_action :authorize_editor, only: [:edit]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id]) #display the topic that matches the id passed in URL params
  end

  def new
    @topic = Topic.new #create a new topic
  end

  def create
    @topic = Topic.new(topic_params)
    # @topic = Topic.new
    # @topic.name = params[:topic][:name]
    # @topic.description = params[:topic][:description]
    # @topic.public = params[:topic][:public]

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

  # Refactor: below replaced by topic_params
  # @topic.name = params[:topic][:name]
  # @topic.description = params[:topic][:description]
  # @topic.public = params[:topic][:public]

    if @topic.save
       flash[:notice] = "Topic was updated successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

   def destroy
     @topic = Topic.find(params[:id])

     if @topic.destroy
       flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
       redirect_to action: :index #redirect_to action: :index is the same as redirect_to topics_path because topics_path routes to the index action per Rails' resourceful routing.
     else
       flash.now[:alert] = "There was an error deleting the topic."
       render :show
     end
   end

   private

   def topic_params
     params.require(:topic).permit(:name, :description, :public)
   end

   def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that"
       redirect_to topics_path
     end
   end

   def authorize_editor
     unless current_user.moderator? || current_user.admin?
       flash[:alert] = "You must be an admin or a moderator to do that"
       redirect_to topics_path
     end
   end

end
