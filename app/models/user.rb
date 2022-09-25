class User < ApplicationRecord

  after_create do |user|
    profile = Profile.create(user_id: user.id)
    profile.attach_default_avatar
    profile.attach_default_banner
    # if user.email
    #   UserMailer.with(user: user).sign_up_email.deliver_now
    # end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
  
  def email_required?
    false
  end
  
  # One user can create many posts, each post created by one user
  has_many :created_posts, foreign_key: :creator_id, class_name: "Post", :dependent => :destroy

  # One user can create many comments, each comment belongs to one user
  has_many :created_comments, foreign_key: :creator_id, class_name: "Comment", :dependent => :destroy

  # One user has one profile
  has_one :profile, :dependent => :destroy

  # A user can like many comments/posts (likeables)
  has_many :likes, foreign_key: :liker_id, :dependent => :destroy

  # A user can like many comments/posts (likeables)
  has_many :dislikes, foreign_key: :disliker_id, :dependent => :destroy

  # A user can be either the sender or receiver of many notifications
  has_many :sent_notifications, foreign_key: :sender_id, class_name: "Notification", :dependent => :destroy
  has_many :received_notifications, foreign_key: :receiver_id, class_name: "Notification", :dependent => :destroy
  
  # Friend requests
  has_many :sent_friend_requests, ->{ where pending: true}, class_name: "Friendship", foreign_key: :sender_id, :dependent => :destroy
  has_many :received_friend_requests, ->{ where pending: true}, class_name: "Friendship", foreign_key: :receiver_id, :dependent => :destroy

  # Each user can have many friends and can be a friend to many users
  # https://stackoverflow.com/questions/37244283/how-to-model-a-mutual-friendship-in-rails
  has_many :sent_friendships, ->{ where pending: false}, :dependent => :destroy, class_name: "Friendship", foreign_key: :sender_id
  has_many :received_friendships, ->{ where pending: false}, :dependent => :destroy, class_name: "Friendship", foreign_key: :receiver_id

  has_many :sent_friends, :through => :sent_friendships, source: :receiver
  has_many :received_friends, :through => :received_friendships, source: :sender

  def friends
    sent_friends + received_friends
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(username: data['name'], email: data['email'], password: Devise.friendly_token[0,20])
    end
    user
  end
end

