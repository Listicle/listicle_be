class Mutations::UpdateTask < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :task_name, String, required: false
  argument :completed, Boolean, required: false
  argument :activity_id, Integer, required: false

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(id:, **args)
    task = Task.find(id)
        if task.update!(args)
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
