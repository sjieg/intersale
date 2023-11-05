class CollectionItem < ApplicationRecord
  has_paper_trail
  has_many_attached :images

  belongs_to :collection
  enum availability: {available: 0, unavailable: 1, sold: 2}, _default: :available
end
