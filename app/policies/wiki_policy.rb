class WikiPolicy < ApplicationPolicy
    attr_reader :user, :wiki

    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end

    def index?
        user.present?
      end

    def create?
        user.admin? || user.member? || user.guest?
    end

    def show?
      scope.where(:id => record.id).exists?
    end

    def new?
        user.present?
    end

    def update?
        user.present?
    end

    def edit?
        user.present?
    end

    def destroy?
        user.admin? || (@wiki.user == user)
    end

    class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
            @user = user
            @scope = scope
        end

        def resolve
          wikis = []
          if user.role == 'admin'
            wikis = scope.all # if the user is an admin, show them all the wikis
          elsif user.role == 'member'
            all_wikis = scope.all
            all_wikis.each do |wiki|
              if !wiki.private? || wiki.user == user || wiki.users.include?(user)
                wikis << wiki
              end
            end
          else
            all_wikis = scope.all
            wikis = []
            all_wikis.each do |wiki|
              if !wiki.private? || wiki.users.include?(user)
                wikis << wiki
              end
            end
          end
          wikis
        end
      end
    end
