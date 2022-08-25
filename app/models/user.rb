class User < ApplicationRecord

  after_create do |user|
    Profile.new(user_id: user.id)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # One user can create many posts, each post created by one user
  has_many :created_posts, foreign_key: :creator_id, class_name: "Post", :dependent => :destroy

  # One user can create many comments, each comment belongs to one user
  has_many :created_comments, foreign_key: :creator_id, class_name: "Comment", :dependent => :destroy

  # One user has one profile
  has_one :profile, :dependent => :destroy

  # Each user can have many friends and can be a friend to many users
  # Since a friendship goes both ways, each friendship requires 2 rows.
  # Since 2 rows need to be deleted, handle deletion manually in controller instead of using :dependent => :destroy ?
  has_many :friendships, :dependent => :destroy
  has_many :friends, through: :friendships, source: :user

  # A user has many sent friend requests
  has_many :sent_friend_requests, class_name: "FriendRequest", foreign_key: :sender, :dependent => :destroy

  # A user has many received friend requests
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: :receiver, :dependent => :destroy

  # A user can like many comments/posts (likeables)
  has_many :likes, foreign_key: :liker_id, :dependent => :destroy

  # A user can like many comments/posts (likeables)
  has_many :dislikes, foreign_key: :disliker_id, :dependent => :destroy

  # A user can be either the sender or receiver of many notifications
  has_many :received_notifications, foreign_key: :receiver_id, class_name: "Notification"
end
