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
    if wiki.private
      user == wiki.user
    else
      true
    end
  end

  def edit?
    if wiki.private
      user == wiki.user
    else
      user.present? || user.admin?
    end
  end

  def destroy?
    if wiki.private
      user == wiki.user
    else
      user.present? || user.admin?
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all
      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.user == user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
