module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :destroy_project, mutation: Mutations::DestroyProject
<<<<<<< HEAD
    field :create_task, mutation: Mutations::CreateTask
    field :destroy_task, mutation: Mutations::DestroyTask
    field :update_task, mutation: Mutations::UpdateTask
    field :update_activity, mutation: Mutations::UpdateActivity
    field :create_activity, mutation: Mutations::CreateActivity
    field :destroy_activity, mutation: Mutations::DestroyActivity
=======

    field :create_task, mutation: Mutations::CreateTask
    field :destroy_task, mutation: Mutations::DestroyTask
    field :update_task, mutation: Mutations::UpdateTask

    field :update_activity, mutation: Mutations::UpdateActivity
    field :create_activity, mutation: Mutations::CreateActivity
    field :destroy_activity, mutation: Mutations::DestroyActivity

>>>>>>> 73f6bbff746d7c0d0c6d5b0da70f885afd0b3e2a
  end
end
