class Relationship < ApplicationRecord
# these behave as if 'follower' model and 'followed' model exist.
# but actually they don't exist, only 'User' model exists.
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
