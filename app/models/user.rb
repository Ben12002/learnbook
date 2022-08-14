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

  
end
