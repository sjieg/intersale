# frozen_string_literal: true

class CollectionPolicy < ApplicationPolicy
  # def index?
  #   false
  # end
  #
  # def show?
  #   false
  # end
  #
  # def create?
  #   false
  # end
  #
  # def new?
  #   create?
  # end
  #
  # def update?
  #   false
  # end
  #
  # def edit?
  #   update?
  # end
  #
  # def destroy?
  #   false
  # end

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
