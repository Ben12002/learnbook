class Notification < ApplicationRecord
  validates_uniqueness_of :message, :scope => :link

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  MESSAGES = { comment: "has commented on your post",
               replied_comment: "has replied to your comment",
               like_post: "has liked your post",
               like_comment: "has liked your comment" }

  def self.create_and_send(sender, receiver, type, link)
    if sender.id != receiver.id
      message = "#{sender.username} #{MESSAGES[type]}"
      receiver.received_notifications.create(sender_id: sender.id, message: message, link: link)
    end
  end

  def set_to_seen
    self.seen = true
    self.save
  end
end
