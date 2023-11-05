class Collection < ApplicationRecord
  attr_accessor :user
  has_many :user_collections, dependent: :destroy
  has_many :users, through: :user_collections
  has_many :collection_items, dependent: :destroy

  before_validation :add_user_to_collection

  def add_user_to_collection
    user_collections.build(user: user, role: :owner)
  end

  def minimum_role?(user, role)
    role_id = UserCollection.roles[role]
    roles = UserCollection.roles.select { _2 >= role_id }
    roles.include? user_collections.find_by(user: user)&.role
  end
end
