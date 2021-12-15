module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :destroy_project, mutation: Mutations::DestroyProject
    field :create_task, mutation: Mutations::CreateTask
    field :destroy_task, mutation: Mutations::DestroyTask
    field :update_task, mutation: Mutations::UpdateTask
    field :update_activity, mutation: Mutations::UpdateActivity
    field :create_activity, mutation: Mutations::CreateActivity
    field :destroy_activity, mutation: Mutations::DestroyActivity
  end
end
