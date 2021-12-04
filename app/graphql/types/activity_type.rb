module Types
  class ActivityType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :project_id, Integer, null: false
    field :status, Integer, null: true
    field :tasks, [Types::TaskType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def tasks_count
      object.tasks.size
    end
  end
end
