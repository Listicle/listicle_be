class Mutations::DestroyProject < Mutations::BaseMutation
  argument :id, String, required: true
  argument :user_id, Integer, required: true

  field :project, Types::ProjectType, null: false
  field :errors, [String], null: false

  def resolve(id:, user_id:)
    project = Project.find(id)
        if project.destroy
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
