class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User" # This is necessary so that user.friends will work.
end
