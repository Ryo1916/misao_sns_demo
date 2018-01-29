class Post < ApplicationRecord
  # This is for upload image from form field.
  mount_uploader :image_name, ImageUploader

  # This is the associations to other tables.
  belongs_to :user
  has_many :likes, dependent: :destroy

  # Validations for post.
  validates :content, { presence: true, length: { maximum: 1000 } }
end
