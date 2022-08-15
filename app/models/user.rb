class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # One user can create many posts, each post created by one user
  has_many :created_posts, foreign_key: :creator_id, class_name: "Post"

  # A user can like many posts, a post can be liked by many users
  has_many :post_likings, foreign_key: :liker_id
  has_many :liked_posts, through: :post_likings

  # One user can create many comments, each comment belongs to one user
  has_many :created_comments, foreign_key: :creator_id, class_name: "Comment"

  # One user has one profile
  has_one :profile

  # Each user can have many friends and can be a friend to many users
  # Since a friendship goes both ways, one friendship requires 2 rows.
  has_many :friendships
  has_many :friends, through: :friendships

  # A user has many sent friend requests
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: :sender

  # A user has many received friend requests
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: :receiver
end
