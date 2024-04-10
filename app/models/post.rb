class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :views, dependent: :destroy

  #before_save :like_rate_calc

  #must contain at least one image or video
  validate :file_type, :images_presence
  validates :body, presence: true

  def calculate_like_rate
    if self.unique_views_count > 0
      self.like_rate = (self.likes_count.to_f * 100 / self.unique_views_count).round(1)
      self.save
    end
  end

  private

  def file_type
    images.each do |image|
      unless image.content_type.in?(%w(image/jpeg image/png image/gif video/mp4 video/mov))
        errors.add(:images, 'Must be an image or video of a specific format')
      end
    end
  end

  def images_presence
    errors.add(:images, 'Must be at least one video or image') if images.blank?
  end
end
