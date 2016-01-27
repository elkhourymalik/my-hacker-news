class Post < ActiveRecord::Base
  belongs_to :user
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :name, length: { minimum: 5 }
  validates :url, uniqueness: true
  validates :url, presence: true
  validates :url, format: { with: /https?:\/\/[\S]+/, message: "invalid url" }
end
