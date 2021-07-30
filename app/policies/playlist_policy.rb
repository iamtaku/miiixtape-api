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
     user == record.user || record.editable? 
    end
    
    def create?
      true
    end
    
    def destroy?
      record.user == user
    end
end
