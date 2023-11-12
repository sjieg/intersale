# frozen_string_literal: true

class CollectionItemPolicy < ApplicationPolicy
  # def index?
  #   false
  # end
  #
  def show?
    @user.collections.include?(@record.collection) || @user.admin?
  end

  def create?
    @record.collection.minimum_role?(@user, :manager) || @user.admin?
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    update?
  end
  #
  # def destroy?
  #   false
  # end

  class Scope < Scope
    def resolve
      # if @user.admin?
      #   return scope.all
      # end
      scope
        # Onwers or managers of the collection items
        .joins(:collection, collection: :user_collections)
        .where(collection: {user_collections: {user: @user, role: [:owner, :manager]}})
        .or(
          # Relatives or acquaintances of the collection items if the items is available
          scope
            .joins(:collection, collection: :user_collections)
            .where(collection: {user_collections: {user: @user, role: [:relative, :acquaintance]}})
            .where(availability: :available)
        ).distinct
    end
  end
end
