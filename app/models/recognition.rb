class Recognition < ApplicationRecord
  ACCEPTED_CONTENT_TYPES = %i[image/png image/jpeg].freeze

  belongs_to :user
  has_one_attached :image

  validates :image, attached: true, content_type: ACCEPTED_CONTENT_TYPES, size: { less_than: 3.megabytes }
end
