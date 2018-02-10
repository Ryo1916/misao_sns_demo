class Post < ApplicationRecord
# This is for upload post image from post form.
  mount_uploader :image_name, ImageUploader

# This is the associations to other tables.
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

# Validations for post.
  validates :content, { presence: true, length: { maximum: 1000 } }
  # validate  :picture_size

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  private

    def like(post_id)
      likes.create(post_id: post_id)
    end

    def unlike(post_id)
      likes.find_by(post_id: post_id).destroy
    end

    def like?(user_id)
      liking_users.include?(user_id)
    end

    # def picture_size
    #   if picture.size > 5.megabytes
    #     errors.add(:picture, "should be less than 5MB")
    #   end
    # end

end
