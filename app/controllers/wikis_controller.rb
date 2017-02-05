class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new

    if @wiki.save
      @wiki.labels = Label.update_labels(params[:wiki][:labels])
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end


end
