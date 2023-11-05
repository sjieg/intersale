class UserCollection < ApplicationRecord
  belongs_to :user
  belongs_to :collection
  enum role: {owner: 31, manager: 30, relative: 16, acquaintance: 8}
end
