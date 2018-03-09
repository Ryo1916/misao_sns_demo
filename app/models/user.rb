class User < ApplicationRecord
# This is for upload user image from user creation form and usre edit form.
  mount_uploader :image_name, ImageUploader

# This is to translate entered address to latitude and longitude.
  geocoded_by :address
  after_validation :geocode

# This is the associations to other tables.
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
    # Rails recognized automatically relational table by foreign_key(ex: user_id, post_id).
    # But now we want to use follower_id as a foreign_key and rails cannot understand this is it or not.
    # So we have to write the following lines to use follower_id as a foreign_key.
    # Moreover, 'active_relationships' and 'passive_relationships' is not real name.
    # That's why we need write 'class_name: "Relationship"''.
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
    # => rails can implicitly recognize that 'source:' is ':follower' when 'source:' is omitted.
    # and then, rails automatically start searching 'follower_id' as a foreign_key.
    # In above case, model name is ':follower', so it can be omitted.

# Validatoin for columns data.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, uniqueness: true, on: :update
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

# This is to use devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable

# This is for omniauth authentication.
  # def self.find_or_create_from_oauth(auth)
  #   User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
  #     user.name = auth.info.name || auth.info.nickname
  #     user.email = auth.info.email || User.dummy_email(auth)
  #     user.password = Devise.friendly_token[0, 20]
  #     user.image_name = auth.info.image
  #   end
  # end

  def self.create_from_omniauth(auth)
    User.create(
      name: auth.info.name || auth.info.nickname,
      email: auth.info.email || User.dummy_email(auth),
      password: Devise.friendly_token[0, 20],
      image_name: auth.info.image,
      provider: auth.provider,
      uid: auth.uid
    )
  end

# These are for following features.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
