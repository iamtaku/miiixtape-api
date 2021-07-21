class PlaylistItemPolicy < ApplicationPolicy
    def resolve
      scope.all
    end
    def index?
      true
    end

    def show?
      # true
      false
    end
    
    def update?
      record.playlist.editable? || user == record.playlist.user 
    end
    
    def destroy?
      user == record.user
    end
end
