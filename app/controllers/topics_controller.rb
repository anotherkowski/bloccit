class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    # @topics = Topic.all
    @topics = Topic.visible_to(current_user)
  end

  def show
    @topic = Topic.find(params[:id]) #display the topic that matches the id passed in URL params
    unless @topic.public || current_user
      flash[:alert] = "You must be signed in to view private topics."
      redirect_to new_session_path
    end
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
      @topic.labels = Label.update_labels(params[:topic][:labels])
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
      @topic.labels = Label.update_labels(params[:topic][:labels])
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

end
