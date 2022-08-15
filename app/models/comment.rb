class Comment < ApplicationRecord

  # One user can create many comments, each comment belongs to one user
  belongs_to :creator, class_name: "User"

  # A comment belongs to a post or comment
  belongs_to :commentable, polymorphic: true

  # A comment has many comments
  has_many :comments, as: :commentable
end
