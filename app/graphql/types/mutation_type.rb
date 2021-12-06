module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
  end
end
