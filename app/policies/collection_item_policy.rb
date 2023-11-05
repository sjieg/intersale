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
        .includes(:collection, collection: :user_collections)
        .where(collection: {user_collections: {user: @user, role: [:owner, :manager]}})
        .merge(
          scope
            .includes(:collection, collection: :user_collections)
            .where(collection: {user_collections: {user: @user, role: [:relative, :acquaintance]}})
            .where(availability: :available)
        ).distinct
    end
  end
end
