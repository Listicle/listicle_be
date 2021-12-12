module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :destroy_project, mutation: Mutations::DestroyProject
    field :update_activity, mutation: Mutations::UpdateActivity
  end
end
