class Bookmark < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true
  validates :url, format: {with: URI.regexp}, if: Proc.new {|a| a.url.present?}
  validates :description, presence:  true

  scope :alpha, lambda { order("bookmarks.description, ASC") }

  def self.search(query)

      self.where("description like ?", "%#{query}%" )

  end

end
