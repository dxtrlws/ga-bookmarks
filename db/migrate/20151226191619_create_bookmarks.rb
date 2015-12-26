class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user
      t.string :url
      t.string :description

      t.timestamps null: false
    end

  end
end
