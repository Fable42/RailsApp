class Like < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: [:likeable_id, :likeable_type]}
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true
end
