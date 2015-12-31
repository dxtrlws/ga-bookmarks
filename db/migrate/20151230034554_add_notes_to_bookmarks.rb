class AddNotesToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :notes, :text
  end
end
