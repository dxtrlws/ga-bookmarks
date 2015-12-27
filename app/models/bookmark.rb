class Bookmark < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true
  validates :url, format: {with: URI.regexp}, if: Proc.new {|a| a.url.present?}
  validates_presence_of :description

end
