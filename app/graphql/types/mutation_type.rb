module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :destroy_project, mutation: Mutations::DestroyProject
    field :create_task, mutation: Mutations::CreateTask
    field :destroy_task, mutation: Mutations::DestroyTask
  end
end
