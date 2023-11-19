class CollectionItem < ApplicationRecord
  has_paper_trail
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_fill: [50, 50]
  end

  scope :with_images, -> { joins(:images_attachments).uniq }

  belongs_to :collection
  enum availability: {available: 0, unavailable: 1, sold: 2}, _default: :available
end
