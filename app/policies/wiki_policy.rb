class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    user.present? || user.admin?
  end

  def new?
    user.present? || user.admin?
  end

  def create?
    user.present? || user.admin?
  end

  def show?
    true
  end

  def edit?
    user.present? || user.admin?
  end

  def destroy?
    user.present? || user.admin?
  end
end
