class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def index
    @bookmarks = Bookmark.all
    @tests = current_user.bookmarks
  end

  def new
    @bookmark = Bookmark.new

  end

  def show
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = current_user.bookmarks.build bookmark_params

    if @bookmark.save
      redirect_to bookmarks_path
    else
      flash[:notice] = "Please enter a valid URL"
      render 'new'
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      flash[:notice] = "Your bookmark has been updated successfully"
      redirect_to bookmarks_path
    else
      render 'edit'
    end
  end

  def delete
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    @bookmark = Bookmark.find(params[:id]).destroy
    flash[:notice] = "Your bookmark has been removed"
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :description)
  end

end
