class Profile < ApplicationRecord
  # One user has one profile
  belongs_to :user

  # has_one_attached :avatar

  # has_one_attached :banner

  has_one_attached :avatar do |attachable|
    attachable.variant :large_thumbnail, resize_to_limit: [150, 150]
    attachable.variant :small_thumbnail, resize_to_limit: [30, 30]
  end

  has_one_attached :banner do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
