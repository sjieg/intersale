# frozen_string_literal: true

class CollectionPolicy < ApplicationPolicy
  # def index?
  #   false
  # end
  #
  def show?
    @record.minimum_role?(@user, :acquaintance) || @user.admin?
  end

  def create?
    @record.minimum_role?(@user, :owner) || @user.admin?
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

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: @user.collections).distinct
      end
    end
  end
end
