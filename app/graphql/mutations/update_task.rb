class Mutations::UpdateTask < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :task_name, String, required: true
  argument :completed, Boolean, required: true
  argument :activity_id, Integer, required: true

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
