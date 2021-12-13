class Mutations::DestroyTask < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :activity_id, Integer, required: true

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(id:, activity_id:)
    task = Task.find(id)
        if task.destroy
      {
        task: task,
        errors: []
      }
    else
      {
        task: nil,
        errors: task.errors.full_messages
      }
    end
  end
end
