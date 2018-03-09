class Share < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :shares_count

  # Validations for shares.
  validates :user_id, { presence: true }
  validates :post_id, { presence: true }
end
