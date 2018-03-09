class Post < ApplicationRecord
# This is for upload post image from post form.
  mount_uploader :image_name, ImageUploader

# This is the associations to other tables.
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :sharing_users, through: :shares, source: :user

# Validations for post.
  validates :content, { presence: true, length: { maximum: 1000 } }
  # validate  :picture_size

  def like(user)
    likes.create(user_id: user_id)
  end

  def unlike(user)
    likes.find_by(user_id: user_id).destroy
  end

# For Checking user already liked or not
  def like?(user)
    liking_users.include?(user)
  end

# This is the same method that the like? method
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

# To check user already shared or not.
  def share_user(user_id)
    self.shares.find_by(user_id: user_id)
  end

  # def picture_size
  #   if picture.size > 5.megabytes
  #     errors.add(:picture, "should be less than 5MB")
  #   end
  # end

end
