class CollaboratorsController < ApplicationController


  before_action :set_wiki

  def index
    @collaborators = @wiki.collaborators
    @users = User.all
  end

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = @wiki.collaborators.new(:user_id => params[:user_id])

    if @collaborator.save
       flash[:notice] = "Collaborator was added to this wiki."
       redirect_to @wiki
    else
       flash[:error] = "There was an error adding the collaborator.  Please try again."
       render :back
    end
  end

  def destroy
    @collaborator = @wiki.collaborators.find(params[:id])

    if @collaborator.destroy
       flash[:notice] = "Collaborator was removed from this wiki."
       redirect_to @wiki
    else
       flash[:error] = "Collaborator could not be removed. Please try again."
       render :index
    end
  end

  def set_wiki
     @wiki = Wiki.find(params[:wiki_id])
  end

end
