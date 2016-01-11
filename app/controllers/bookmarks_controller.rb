class BookmarksController < ApplicationController
  # user has to be logged in before they can access their list of bookmarks
  before_action :authenticate_user!

  def index
    # sets variable to show bookmarks created by user
    @search = params[:search]
    @bookmarks = @search ? Bookmark.search(@search) :
        @bookmarks = current_user.bookmarks.order("description ASC")


  end

  def new
    @bookmark = Bookmark.new
  end


  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    # creates new bookmark that's related to the current signed in user.
    # book_params is the safe parameters that can be passed on
    @bookmark = current_user.bookmarks.build bookmark_params

    if @bookmark.save
      # flash message to display if the bookmark has been saved
      flash[:notice] = "Your bookmark has successfully been saved"
      redirect_to bookmarks_path
    else
      # displays error message to user based on the validations in the bookmark model for the URL field
      flash[:notice] = "Please enter a valid URL"
      render 'new'
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      # flash message to display if the bookmark is updated successfully
      flash[:notice] = "Your bookmark has been updated successfully"
      # redirects to the list of bookmarks that was created or edited by the user
      redirect_to bookmarks_path
    else
      flash[:notice] = "Please enter a valid URL"
      render 'edit'
    end
  end

  def delete
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    # finds the bookmark the user wants to delete by the ID number
    @bookmark = Bookmark.find(params[:id]).destroy
    # flash message to display to the user that their bookmark has been deleted
    flash[:notice] = "Your bookmark has been removed successfully"
    # redirects to the list of bookmarks created by the user
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    # private method to pass a set of safe params through the URL when saving or editing bookmarks
    params.require(:bookmark).permit(:url,:notes, :description)
  end

end
