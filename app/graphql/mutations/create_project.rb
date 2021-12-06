class Mutations::CreateProject < Mutations::BaseMutation
  argument :project_name, String, required: true
  argument :user_id, Integer, required: true

  field :project, Types::ProjectType, null: false
  field :errors, [String], null: false

  def resolve(project_name:, user_id:)
    project = Project.new(project_name: project_name, user_id: user_id)
        if project.save
      {
        project: project,
        errors: []
      }
    else
      {
        project: nil,
        errors: project.errors.full_messages
      }
    end
  end
end
