module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :task_name, String, null: true
    field :completed, Boolean, null: true
    field :activity_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
