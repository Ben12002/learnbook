class Friendship < ApplicationRecord

  validates_uniqueness_of :sender_id, :scope => :receiver_id

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  # e.g: User A sends user B a friend request, and user B sends user A a request. 
  # User A accepts user B's request. Then User A's request should be deleted. 
  # User B shouldn't see it in their inbox.
  def self.destroy_requests_after_accept(sender_id, receiver_id)
    User.find(receiver_id).sent_friend_requests.where(receiver_id: sender_id).destroy_all
  end

  def self.friendship_given_friend(user_one, user_two)
    Friendship.where(sender_id: user_one.id, receiver_id: user_two.id).or(Friendship.where(sender_id: user_two.id, receiver_id: user_one.id)).first
  end
end

class FriendValidator < ActiveModel::Validator
  def validate(record)
    friendship_exists_one = Friendship.exists?(sender_id: record.sender_id, receiver_id: record.receiver_id, pending: false)
    friendship_exists_two = Friendship.exists?(sender_id: record.receiver_id, receiver_id: record.sender_id, pending: false)

    if friendship_exists_one || friendship_exists_two
      record.errors.add :base, "Friendship already exists."
    end
  end
end
