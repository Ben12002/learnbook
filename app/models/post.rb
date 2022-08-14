class Post < ApplicationRecord

  # One user can create many posts, each post created by one user
  belongs_to :creator, class_name: "User"
  
  # A user can like many posts, a post can be liked by many users
  has_many :post_likings, foreign_key: :liked_post_id
  has_many :likers, through: :post_likings # source: :liker


end
