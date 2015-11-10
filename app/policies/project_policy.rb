class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    # user is a method defined in ApplicationPolicy,
    # from which ProjectPolicy inherits
    #
    # record is another method defined in ApplicationPolicy
    # in this case, it is an instance of a Project model
    #
    # what this is doing is getting all the records in the roles table which
    # belong to this project, and then checking if any of those records have a
    # user_id field set to user.
    user.try(:admin?) || record.roles.exists?(user_id: user)
  end
end
