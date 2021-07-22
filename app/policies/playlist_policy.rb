class PlaylistPolicy < ApplicationPolicy
    def resolve
      scope.all
    end

    def index?
      true
    end

    def show?
      true
    end
    
    def update?
      record.editable? || user == record.user 
    end
    
    def destroy?
      record.user == user
    end
end
