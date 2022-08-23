class Post < ApplicationRecord

  # One user can create many posts, each post created by one user
  belongs_to :creator, class_name: "User"

  # A post has many comments
  has_many :comments, as: :commentable, :dependent => :destroy

  # A post can be liked; therefore it has many likes
  has_many :likes, as: :likeable, :dependent => :destroy
  has_many :likers, through: :likes


  def top_level_comments
    self.comments.where(parent_id: nil)
  end
end
