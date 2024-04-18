class User < ApplicationRecord
  after_commit :set_default_image, on: %i[ create update ]

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :views, dependent: :destroy
  has_one_attached :profile_image

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :tag,
    presence: true,
    uniqueness: true,
    length: { in: 3..20 },
    format: { without: /\s/ } #нельзя использовать пробел

  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 3..25 }

  private

  def set_default_image
    unless profile_image.attached?
      profile_image.attach(
        io: File.open(Rails.root.join("app", "assets", "images", "profile-def.png")),
        filename: 'profile-def.png',
        content_type: 'image/png'
      )
    end
  end
end
