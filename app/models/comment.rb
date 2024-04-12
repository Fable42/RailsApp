class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
  has_many :likes, as: :likeable
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, length: { maximum: 250 }, presence: true
end
