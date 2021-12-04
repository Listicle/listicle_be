module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :project_name, String, null: true
    field :user_id, Integer, null: false
    field :activities, [Types::ActivityType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def activities_count
      object.activities.size
    end
  end
end
