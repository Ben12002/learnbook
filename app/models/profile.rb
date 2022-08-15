class Profile < ApplicationRecord
  # One user has one profile
  belongs_to :user
end
