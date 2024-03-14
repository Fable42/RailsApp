class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_validation :titleize

  validates :tag,
    presence: true,
    uniqueness: true,
    length: { in: 3..20 },
    format: { without: /\s/ } #нельзя использовать пробел

  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /\A[A-Z][a-z]*( [A-Z][a-z]*)?\z/ }, #первая буква всегда заглавная а остальные строчные, и допускается исп двух слов
    length: { in: 3..16 }
  
  def titleize
    self.name = name.to_s.split.map(&:capitalize).join(' ')
    self.tag = tag.to_s.split.map(&:capitalize).join(' ')
  end

end
