class Comment < ApplicationRecord
  validates :body, :presence => true

  # One user can create many comments, each comment belongs to one user
  belongs_to :creator, class_name: "User"

  # A comment belongs to a post or comment
  belongs_to :commentable, polymorphic: true

  # A comment has many comments
  has_many :comments, foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Comment", optional: true

  # A comment can be liked; therefore it has many likes
  has_many :likes, as: :likeable, :dependent => :destroy
  has_many :likers, through: :likes

  # A comment can be disliked; therefore it has many dislikes
  has_many :dislikes, as: :dislikeable, :dependent => :destroy
  has_many :dislikers, through: :dislikes
end
