class Like < ApplicationRecord
  # This is the associations to other tables.
  belongs_to :user
  belongs_to :post, counter_cache: :likes_count

  # Validations for likes.
  validates :user_id, { presence: true }
  validates :post_id, { presence: true }
end
