class User < ApplicationRecord
# This is for upload image file to posts table.
  mount_uploader :image_name, ImageUploader

# This is the associations to other tables.
  has_many :posts, dependent: :destroy
  has_one :likes, dependent: :destroy
  # has_many :messages, dependent: :destroy
    # rails recognized automatically relational table by foreign_key(ex: user_id, post_id).
    # but now we want to use follower_id as a foreign_key and rails cannot understand this is foreign_key or not.
    # so we have to write the following lines to use follower_id as a foreign_key.
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  # Validatoin for columns data.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # This is to use devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
end
