module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :destroy_project, mutation: Mutations::DestroyProject
    field :update_activity, mutation: Mutations::UpdateActivity
    field :create_activity, mutation: Mutations::CreateActivity
    field :destroy_activity, mutation: Mutations::DestroyActivity
  end
end
