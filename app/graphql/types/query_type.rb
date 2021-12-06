module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    # include GraphQL::Types::Relay::HasNodeField
    # include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    # /user/:id
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:) #may not need colon
      User.find(id)
    end

    field :projects, [Types::ProjectType], null: false

    def projects
      Project.all
    end

    field :project, Types::ProjectType, null: false do
      argument :id, ID, required: true
    end

    def project(id:)
      Project.find(id)
    end

    field :activities, [Types::ActivityType], null: false

    def activity
      Activity.all
    end

    field :activity, Types::ActivityType, null: false do
      argument :id, ID, required: true
    end

    field :tasks, [Types::TaskType], null: false

    def tasks
      Task.all
    end

    field :task, Types::TaskType, null: false do
      argument :id, ID, required: true
    end

    def task(id:)
      Task.find(id)
    end
  end
end
