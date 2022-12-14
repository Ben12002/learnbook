class Profile < ApplicationRecord
  # One user has one profile
  belongs_to :user

  has_one_attached :avatar do |attachable|
    attachable.variant :large_thumbnail, resize_to_limit: [150, 150]
    attachable.variant :small_thumbnail, resize_to_limit: [30, 30]
  end

  has_one_attached :banner do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  def attach_default_avatar
    self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_avatar.jpeg")), filename: 'default_avatar.jpg' , content_type: "image/jpg")
  end

  def attach_default_banner
    self.banner.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_banner.jpeg")), filename: 'default_banner.jpg' , content_type: "image/jpg")
  end
end
