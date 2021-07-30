class PlaylistItemPolicy < ApplicationPolicy
    def resolve
      scope.all
    end
    def index?
      true
    end

    def show?
      false
    end
    
    def update?
      record.playlist.editable? || user == record.playlist.user 
    end
    
    def destroy?
      user == record.user
    end
    
    def create?
      record.editable? || user == record.user 
    end
end
